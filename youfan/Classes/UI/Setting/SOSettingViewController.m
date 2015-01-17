//
//  SOSettingViewController.m
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOSettingViewController.h"
#import "SOLocationManager.h"
#import "URLHelper.h"
#import "NoticeHelp.h"

@interface SOSettingViewController ()

@end

@implementation SOSettingViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我";
    }
    return self;
}


- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration
{
   if(self = [super initWithConfiguration:configuration])
    {
        self.title = @"我";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = TRUE;
    
}



- (NSURL *)loadCacheURL
{
    if ([SOLoginManager shareInstance].hasLogin) {
        NSURL *url = [URLHelper userCenterWithDid:nil memberNo:[SOLoginManager shareInstance].getLoginUserName];
        return url;
    }else{
        NSURL *url = [URLHelper userCenterWithDid:nil memberNo:nil];
        return url;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
