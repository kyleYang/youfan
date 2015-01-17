//
//  SODinnerViewController.m
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SODinnerViewController.h"
#import "URLHelper.h"
#import "HWLoginViewController.h"
#import "UIHelper.h"

@interface SODinnerViewController ()

@end

@implementation SODinnerViewController


- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration {
    self = [super initWithConfiguration:configuration];
    if (self) {
        // Custom initialization
        self.title = @"活动";
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
        NSURL *url = [URLHelper dinnerUrlWithDid:nil shopId:nil memberNo:[SOLoginManager shareInstance].getLoginUserName];
        return url;
    }else{
        NSURL *url = [URLHelper dinnerUrlWithDid:nil shopId:nil memberNo:nil];
        return url;
    }
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
