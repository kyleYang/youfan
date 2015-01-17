//
//  HW_StartPage_ViewController.h
//  7orange
//
//  Created by robin on 13-1-25.
//  Copyright (c) 2013年 Wong Hsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOBaseViewController.h"


@interface HW_StartPage_ViewController : SOBaseViewController
@property (nonatomic, retain) NSTimer *myTimer;
@property BOOL haveShowOnce;

@property (nonatomic, retain) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, retain) IBOutlet UIButton *gotoIndexPageButton;

- (IBAction)gotoIndexPage:(id)sender;
@end
