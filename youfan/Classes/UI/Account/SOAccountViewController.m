//
//  SOAccountViewController.m
//  youfan
//
//  Created by Kyle on 15/1/13.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "SOAccountViewController.h"
#import "HWLoginViewController.h"
#import "UIHelper.h"
#import "URLHelper.h"

@implementation SOAccountViewController

- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration {
    self = [super initWithConfiguration:configuration];
    if (self) {
        // Custom initialization
        self.title = @"记账";
    }
    return self;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = TRUE;
    
}

- (void)youfanLogin{
    
    if (![SOLoginManager shareInstance].hasLogin) {
        HWLoginViewController *loginViewController = [[HWLoginViewController alloc] initWithNibName:@"HWLoginViewController" bundle:nil];
        loginViewController.target = self;
        loginViewController.method = @selector(loginSucces:);
        [UIHelper tabController:self.rdv_tabBarController presentSubController:loginViewController];
        
        
        
    }
}


- (void)loginSucces:(id)sender
{
    [self reloadCurrentURL];
    
}


- (NSURL *)loadCacheURL
{
    if ([SOLoginManager shareInstance].hasLogin) {
        NSURL *url = [URLHelper accountWithDid:nil shopId:nil memberNo:[SOLoginManager shareInstance].getLoginUserName];
        return url;
    }else{
        NSURL *url = [URLHelper accountWithDid:nil shopId:nil memberNo:nil];
        return url;
    }
}




@end
