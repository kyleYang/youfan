//
//  HW_TicketBase_ViewController.m
//  奇程商旅
//
//  Created by robin on 13-3-27.
//  Copyright (c) 2013年 Wong Hsin. All rights reserved.
//

#import "HW_TicketBase_ViewController.h"
#import "Env.h"


@interface HW_TicketBase_ViewController ()
- (void)createBaseView;
- (void)goBack:(id)sender;
- (void)goPhone:(id)sender;
- (void)goHome:(id)sender;
- (void)callGuestServiceCenter;
@end

@implementation HW_TicketBase_ViewController
//topBar
@synthesize myTopBar = _myTopBar;
@synthesize myBackButton = _myBackButton;
@synthesize myPhoneButton = _myPhoneButton;
@synthesize myHomeButton = _myHomeButton;
@synthesize myTitle = _myTitle;

- (void)createBaseView
{
    
    CGFloat offset = 0.0f;
    if ([Env shareEnv].systemMajorVersion >=7 ) {
        offset = 20.0f;
    }
    
    CGRect topBarRect = CGRectMake(0, offset, 320, 51);
    UIImage *topBarBackImage = [UIImage imageNamed:@"ticket_top"];
    UIImageView *topBarview = [[UIImageView alloc] initWithImage:topBarBackImage];
    [topBarview setFrame:topBarRect];
    topBarview.userInteractionEnabled = YES;
    self.myTopBar = topBarview;
    [self.view addSubview:topBarview];
    
    UIImage *backImage = [UIImage imageNamed:@"arrow_button_normal"];
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 45, 35)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    back.userInteractionEnabled = YES;
    self.myBackButton = back;
    [topBarview addSubview:back];
    
    UIImage *callImage = [UIImage imageNamed:@"navtop_iphone"];
    UIButton *call = [[UIButton alloc] initWithFrame:CGRectMake(234, 5, 33, 33)];
    [call setImage:callImage forState:UIControlStateNormal];
    [call addTarget:self action:@selector(goPhone:) forControlEvents:UIControlEventTouchUpInside];
    self.myPhoneButton = call;
    [topBarview addSubview:call];
    
    UIImage *homeImage = [UIImage imageNamed:@"navtop_home"];
    UIButton *home = [[UIButton alloc] initWithFrame:CGRectMake(280, 5, 33, 33)];
    [home setImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(goHome:) forControlEvents:UIControlEventTouchUpInside];
    self.myHomeButton = home;
    [topBarview addSubview:home];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(105, 8, 120, 30)];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    self.myTitle = title;
    [topBarview addSubview:title];
    
    self.view.userInteractionEnabled = YES;
}

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goPhone:(id)sender
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"电话预定", @"电话预定") delegate:self cancelButtonTitle:NSLocalizedString(@"取消", @"取消") destructiveButtonTitle:NSLocalizedString(@"拨打电话400-188-8181", @"拨打电话400-188-8181") otherButtonTitles: nil];
    [as showInView:self.view];
}

-(void)callGuestServiceCenter
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"])
    {
        UIAlertView *infoAlert1 =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的设备不能打电话" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        infoAlert1.tag = 210;
        [infoAlert1 show];
        return;
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-188-8181"]];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [actionSheet destructiveButtonIndex])
    {
        [self callGuestServiceCenter];
    }
}

- (void)goHome:(id)sender
{

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createBaseView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
