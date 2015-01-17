//
//  HWResetPasswordViewController.h
//  7orange
//
//  Created by robin on 13-2-20.
//  Copyright (c) 2013年 Wong Hsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HW_TicketBase_ViewController.h"
#import "SONetwork.h"


@protocol HWResetPasswordViewController_Delegate <NSObject>

- (void)didResetPassword:(NSString*)userName Password:(NSString*)pwd;

@end

@interface HWResetPasswordViewController : HW_TicketBase_ViewController

@property (assign, nonatomic) id <HWResetPasswordViewController_Delegate> delegate;

//用户输入
@property (nonatomic, retain) IBOutlet UITextField *phoneNumber;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UITextField *passwordCheck;
@property (nonatomic, retain) IBOutlet UITextField *verifyCode;

//键盘出来后可以上下拖动界面
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic) BOOL keyboardVisible;

@property (nonatomic, retain) SONetwork *resetPwdService;

- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)getVerifyCode:(id)sender;
- (IBAction)resetPassword:(id)sender;
@end
