//
//  HW_TicketBase_ViewController.h
//  奇程商旅
//
//  Created by robin on 13-3-27.
//  Copyright (c) 2013年 Wong Hsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HW_TicketBase_ViewController : UIViewController<UIActionSheetDelegate>

//topBar
@property (nonatomic, retain) UIImageView *myTopBar;
@property (nonatomic, retain) UIButton *myBackButton;
@property (nonatomic, retain) UIButton *myPhoneButton;
@property (nonatomic, retain) UIButton *myHomeButton;
@property (nonatomic, retain) UILabel *myTitle;

- (void)goBack:(id)sender;

@end
