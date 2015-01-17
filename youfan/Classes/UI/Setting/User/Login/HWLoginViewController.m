//
//  HWLoginViewController.m
//  7orange
//
//  Created by Wong Hsin on 12-9-23.
//  Copyright (c) 2012年 Wong Hsin. All rights reserved.
//

#import "HWLoginViewController.h"
#import "NSString+Util.h"
#import "SOLoginManager.h"
#import "SONetwork.h"
#import "SVProgressHelp.h"
#import "WXApi.h"
#import "NoticeHelp.h"
#import "API.h"

#define kUserName @"usr"
#define kPassword @"pwd"

@interface HWLoginViewController ()<WXApiDelegate,loginManager>
//登录次数，登录失败后会重试一次，如果还失败就提示用户稍后再试。
@property NSInteger loginTimes;

@property (nonatomic, strong) HWLoginParser *xmlParaser;

@end

@implementation HWLoginViewController

@synthesize passwordTextField = _passwordTextField;
@synthesize usernameTextField = _usernameTextField;

@synthesize scrollView = _scrollView;
@synthesize wxLoginButton = _wxLoginButton;

@synthesize loginService = _loginService;

@synthesize keyboardVisible = _keyboardVisible;

//用于通知那些需要根据登录成功与否来决定后续业务逻辑得界面，比如机票详情界面需要再登录成功后自动跳到订单填写界面
@synthesize delegate = _delegate;

@synthesize needAutoLoginAfterRegister = _needAutoLoginAfterRegister;

@synthesize loginTimes = _loginTimes;


- (HWLoginParser *)xmlParaser
{
    if (_xmlParaser != nil) {
        return _xmlParaser;
    }
    
    _xmlParaser = [[HWLoginParser alloc] init];
    return _xmlParaser;
}


- (IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (IBAction)goToRegister:(id)sender
{
    HWRegisterViewController *registerCtl = [[HWRegisterViewController alloc] initWithNibName:@"HWRegisterViewController" bundle:nil];
    registerCtl.delegate = self;
    [self.navigationController pushViewController:registerCtl animated:YES];
}

- (void)didRegisterNewUser:(NSString*)userName Password:(NSString*)pwd
{
    if (nil != userName && nil != pwd)
    {
        //保存用户名和密码
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:kUserName];
        [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:kPassword];
        self.usernameTextField.text = userName;
        self.passwordTextField.text = pwd;
        self.needAutoLoginAfterRegister = YES;
    }
}

- (IBAction)gotoGetPassWord:(id)sender
{
    HWResetPasswordViewController *resetPwdCtl = [[HWResetPasswordViewController alloc] initWithNibName:@"HWResetPasswordViewController" bundle:nil];
    resetPwdCtl.delegate = self;
    [self.navigationController pushViewController:resetPwdCtl animated:YES];
}

- (void)didResetPassword:(NSString*)userName Password:(NSString*)pwd
{
    if (nil != userName && nil != pwd)
    {
        //保存用户名和密码
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:kUserName];
        [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:kPassword];
        self.usernameTextField.text = userName;
        self.passwordTextField.text = pwd;
        self.needAutoLoginAfterRegister = YES;
    }
}

- (IBAction)login:(id)sender
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];

   

    if([SOLoginManager shareInstance].hasLogin)
    {
        //登录过，返回
        [self goBack:nil];
        return;
    }
    
    NSString *username = self.usernameTextField.text;
    if (([username isEqualToString:@""])||(nil == username))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"登录名不能为空", @"登录名不能为空")  message:NSLocalizedString(@"请输入手机/邮箱/用户名", @"请输入手机/邮箱/用户名")  delegate:self cancelButtonTitle: NSLocalizedString(@"知道了", @"知道了") otherButtonTitles:nil];
        [alert show];
        return;
    } 
    
    NSString *password = self.passwordTextField.text;
    if (([password isEqualToString:@""]) ||(nil == password))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"密码不能为空", @"密码不能为空") message:NSLocalizedString(@"请输入密码", @"请输入密码") delegate:self cancelButtonTitle:NSLocalizedString(@"知道了", @"知道了") otherButtonTitles:nil];
        [alert show];
        return;
    }

    //保存用户名和密码
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kPassword];

     __weak typeof(self) weakSelf = self;
    [SVProgressHelp showHUD];
    [self.loginService loginWithUsername:username andPwd:password parser:self.xmlParaser success:^(NSString *msg) {
        [SVProgressHelp dismissHUD];
        
        [weakSelf loginSuccess];
    } fail:^(NSString *error) {
        [SVProgressHelp dismissHUDError:error];
    }];
}


- (void)wxLoginRespon:(SendAuthResp *)resq
{
    if (resq.errCode == -4) {
        
        [NoticeHelp showSureAlertInViewController:self message:@"用户拒绝授权"];
        
        return;
    }else if (resq.errCode == -2) {
        
        [NoticeHelp showSureAlertInViewController:self message:@"用户取消"];
        
        return;
    }else if(resq.errCode != 0){
        [NoticeHelp showSureAlertInViewController:self message:@"授权失败"];
        
        return;
    }
    
    
    [SVProgressHelp showHUD];
    __weak typeof(self) weakSelf = self;
    [self.loginService getWechatAccessTokenAPPid:kWXAPPID appSecret:kWXAppSecret code:resq.code success:^(NSDictionary *dic) {
        

        
        
        [weakSelf.loginService getWechatUserInfoAccess_token:[dic objectForKey:@"access_token"] openid:[dic objectForKey:@"openid"] success:^(NSDictionary *dic) {
            
            
            [weakSelf.loginService wxLoginWithOpenId:[dic objectForKey:@"openid"] nickName:[dic objectForKey:@"nickname"] headImgURL:[dic objectForKey:@"headimgurl"] unionId:[dic objectForKey:@"unionid"] sex:[dic objectForKey:@"sex"] city:[dic objectForKey:@"city"] province:[dic objectForKey:@"province"] success:^(NSString *msg) {
                
                NSMutableDictionary *wxResponse = [[NSMutableDictionary alloc] initWithDictionary:dic];
                
                [SVProgressHelp dismissHUD];
                [wxResponse setValue:msg forKey:@"unionid"];
                [SOLoginManager shareInstance].wxUserInfo = wxResponse;
                [weakSelf loginSuccess];
                
            } fail:^(NSString *error) {
                [SVProgressHelp dismissHUDError:error];
            }];
            
            
            
            
        } fail:^(NSString *error) {
            
            [SVProgressHelp dismissHUDError:error];
        }];
        
        
        
    } fail:^(NSString *error) {
        
        [SVProgressHelp dismissHUDError:error];
        
    }];
    
    
    
}



- (IBAction)WXLogin:(id)sender
{
    
    if (![WXApi isWXAppInstalled]) {
        
        
        [NoticeHelp showSureAlertInViewController:self message:@"您还没有安装微信"];
        
        
        return;
    }
    
    
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo"; // @"post_timeline,sns"
    req.openID = kWXAPPID;
    req.state = @"youfan";
    [WXApi sendAuthReq:req viewController:self delegate:self];
}




- (void)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
}


- (void)loginSuccess
{
  

    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        
        if ([weakSelf.target respondsToSelector:weakSelf.method]) {
            [weakSelf.target performSelector:self.method withObject:nil afterDelay:0];
        }
        
    }];
}



- (void)didLoginStatus:(BOOL)success andData:(NSString*)loginCookie;
{
    if(YES == success)
    {
//        NSLog(@"======full cookie:%@", loginCookie);
        //通知监听登录状态者，如机票详情界面
        if (nil != self.delegate)
        {
            [self.delegate  didLogin:YES];
        }
        
        self.loginTimes = 0;
        
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        self.loginTimes += 1;
        if (self.loginTimes >= 1 )
        {
            //通知监听登录状态者，如机票详情界面
            if (nil != self.delegate)
            {
                [self.delegate didLogin:NO];
            }
            
            [self.loginService logout];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"登录失败，请稍后再试", @"登录失败，请稍后再试") message:loginCookie delegate:self cancelButtonTitle:NSLocalizedString(@"知道了", @"知道了") otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            //先注销，然后重新登录
            [self.loginService logout];
            
            //获取用户名和密码
            NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:kUserName];
            NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:kPassword];
            
            __weak typeof(self) weakSelf = self;
            [SVProgressHelp showHUD];
            [self.loginService loginWithUsername:username andPwd:password parser:self.xmlParaser success:^(NSString *msg) {
                [SVProgressHelp dismissHUD];
                [weakSelf loginSuccess];
                
            } fail:^(NSString *error) {
                [SVProgressHelp dismissHUDError:error];
            }];
;
        }
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"登录/预定", @"登录/预定");
        self.loginService = [[SONetwork alloc] init];
        
        self.delegate = nil;
        self.keyboardVisible = NO;
        
        self.needAutoLoginAfterRegister = NO;
        self.loginTimes = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTitle.text = NSLocalizedString(@"登录/预订", @"登录/预订");
    
    self.usernameTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kUserName];
    self.passwordTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kPassword];
    
    if (![WXApi isWXAppInstalled]) {
        self.wxLoginButton.hidden = TRUE;
    }else{
        self.wxLoginButton.hidden = FALSE;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Keyboard Event
- (void)keyboardDidShow: (NSNotification *)notif
{
    if (self.keyboardVisible)
    {
        return;
    }
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey: UIKeyboardFrameBeginUserInfoKey];
    CGSize size = [value CGRectValue].size;
    CGRect frame = self.scrollView.frame;
    frame.size.height -= size.height;
    self.scrollView.frame = frame;
    self.keyboardVisible = YES;
}

- (void)keyboardDidHide: (NSNotification *)notif
{
    if (!self.keyboardVisible) {
        return;
    }
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize size = [value CGRectValue].size;
    CGRect frame = self.scrollView.frame;
    frame.size.height += size.height;
    self.scrollView.frame = frame;
    self.keyboardVisible = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name: UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    [super viewWillAppear:animated];
    
    [SOLoginManager shareInstance].delegate = self;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.needAutoLoginAfterRegister)
    {
        self.needAutoLoginAfterRegister = NO;
        
        NSString *user = [[NSUserDefaults standardUserDefaults] stringForKey:kUserName];
        NSString *pwd = [[NSUserDefaults standardUserDefaults] stringForKey:kPassword];
        [SVProgressHelp showHUD];
        
        __weak typeof(self) weakSelf = self;
        
        [self.loginService loginWithUsername:user andPwd:pwd parser:self.xmlParaser success:^(NSString *msg) {
            [SVProgressHelp dismissHUD];
            [weakSelf loginSuccess];
            
        } fail:^(NSString *error) {
            [SVProgressHelp dismissHUDError:error];
        }];

    }
    [super viewDidAppear:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [super viewWillDisappear:animated];
}




- (void)viewDidDisappear:(BOOL)animated
{
    [SOLoginManager shareInstance].delegate = nil;
    [super viewDidDisappear:animated];
}

- (void)dealloc
{

}

@end
