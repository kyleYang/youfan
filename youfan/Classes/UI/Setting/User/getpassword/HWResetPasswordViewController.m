//
//  HWResetPasswordViewController.m
//  7orange
//
//  Created by robin on 13-2-20.
//  Copyright (c) 2013年 Wong Hsin. All rights reserved.
//

#import "HWResetPasswordViewController.h"
#import "HWVerifyCodeParser.h"
#import "SVProgressHelp.h"

@interface HWResetPasswordViewController ()

@property (nonatomic, strong) HWVerifyCodeParser *verifyparaser;
@property (nonatomic, strong) HWResetPasswordParser *resetparaser;

@end

@implementation HWResetPasswordViewController

@synthesize phoneNumber = _phoneNumber;
@synthesize password = _password;
@synthesize passwordCheck = _passwordCheck;
@synthesize verifyCode = _verifyCode;

//键盘出来后可以上下拖动界面
@synthesize scrollView = _scrollView;
@synthesize keyboardVisible = _keyboardVisible;

@synthesize resetPwdService = _resetPwdService;


- (HWVerifyCodeParser *)verifyparaser
{
    if (_verifyparaser != nil ) {
        return _verifyparaser;
    }
    
    _verifyparaser = [[HWVerifyCodeParser alloc] init];
    return _verifyparaser;
}


- (HWResetPasswordParser *)resetparaser
{
    if (_resetparaser != nil ) {
        return _resetparaser;
    }
    
    _resetparaser = [[HWResetPasswordParser alloc] init];
    return _resetparaser;
}


- (IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender
{
    [self.password resignFirstResponder];
    [self.passwordCheck resignFirstResponder];
    [self.verifyCode resignFirstResponder];
}

- (IBAction)getVerifyCode:(id)sender
{
    NSString *mobile = self.phoneNumber.text;
    if ([mobile isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil  message:NSLocalizedString(@"请输入手机号", @"请输入手机号")  delegate:self cancelButtonTitle: NSLocalizedString(@"知道了", @"知道了") otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [SVProgressHelp showHUD];
    [self.resetPwdService getVerifyCode:mobile parser:self.verifyparaser success:^(NSString *msg) {
        [SVProgressHelp dismissHUDSuccess:msg];
        
        
    } fail:^(NSString *error) {
        [SVProgressHelp dismissHUDError:error];
    }];
}

- (IBAction)resetPassword:(id)sender
{
    NSString *mobile = self.phoneNumber.text;
    if ([mobile isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil  message:NSLocalizedString(@"请输入手机号", @"请输入手机号")  delegate:self cancelButtonTitle: NSLocalizedString(@"知道了", @"知道了") otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSString *pwd1 = self.password.text;
    NSString *pwd2 = self.passwordCheck.text;
    if ([pwd1 isEqualToString:@""] || [pwd2 isEqualToString:@""] || (NO == [pwd1 isEqualToString:pwd1]))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil  message:NSLocalizedString(@"两次输入密码不一致，请重新输入", @"两次输入密码不一致，请重新输入")  delegate:self cancelButtonTitle: NSLocalizedString(@"知道了", @"知道了") otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSString *vcode = self.verifyCode.text;
    if ([vcode isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil  message:NSLocalizedString(@"请输入验证码", @"请输入验证码")  delegate:self cancelButtonTitle: NSLocalizedString(@"知道了", @"知道了") otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [SVProgressHelp showHUD];
    [self.resetPwdService resetPassword:pwd1 Mobile:mobile VerifyCode:vcode parser:self.resetparaser success:^(NSString *msg) {
        [SVProgressHelp dismissHUDSuccess:msg];
        
        NSString *mobile = weakSelf.phoneNumber.text;
        NSString *pwd1 = weakSelf.password.text;
        
        if ([weakSelf.delegate respondsToSelector:@selector(didResetPassword:Password:)])
        {
            [weakSelf.delegate didResetPassword:mobile Password:pwd1];
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    } fail:^(NSString *error) {
        
        if ([weakSelf.delegate respondsToSelector:@selector(didResetPassword:Password:)])
        {
            [weakSelf.delegate didResetPassword:nil Password:nil];
        }
        
        [SVProgressHelp dismissHUDError:error];
    }];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.resetPwdService = [[SONetwork alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTitle.text = NSLocalizedString(@"重置密码", @"重置密码");
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
    if (self.keyboardVisible) {
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
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
}
@end
