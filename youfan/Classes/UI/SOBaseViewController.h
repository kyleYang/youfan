//
//  SOBaseViewController.h
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESErrorView.h"

@interface SOBaseViewController : UIViewController

@property (nonatomic, strong, readonly) ESErrorView *errorView;

- (void)contentRefresh;
- (void)networkErrorNotice;

@end
