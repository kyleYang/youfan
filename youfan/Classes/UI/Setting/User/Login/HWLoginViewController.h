//
//  HWLoginViewController.h
//  7orange
//
//  Created by Wong Hsin on 12-9-23.
//  Copyright (c) 2012年 Wong Hsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HW_TicketBase_ViewController.h"
#import "HWRegisterViewController.h"
#import "HWResetPasswordViewController.h"
#import "SONetwork.h"

@class MBProgressHUD;
@class HWFlightDetailViewController;

@protocol HWLoginViewController_Delegate <NSObject>

- (void)didLogin:(BOOL) loginOK;

@end

@interface HWLoginViewController : HW_TicketBase_ViewController
<HWRegisterViewController_Delegate, HWResetPasswordViewController_Delegate>

//用于通知那些需要根据登录成功与否来决定后续业务逻辑得界面，比如机票详情界面需要再登录成功后自动跳到订单填写界面
@property (assign, nonatomic) id <HWLoginViewController_Delegate> delegate;


@property (nonatomic,weak_delegate) id target;
@property (nonatomic,assign) SEL method;

//用户输入
@property (nonatomic, strong) IBOutlet UITextField *usernameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;

//键盘出来后可以上下拖动界面
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIButton *wxLoginButton;
@property (nonatomic) BOOL keyboardVisible;


@property (nonatomic, strong) SONetwork *loginService;

@property BOOL needAutoLoginAfterRegister;

- (IBAction)login:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)goToRegister:(id)sender;
- (IBAction)gotoGetPassWord:(id)sender;

- (IBAction)WXLogin:(id)sender;

@end
