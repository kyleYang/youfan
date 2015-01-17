//
//  AppDelegate.m
//  youfan
//
//  Created by Kyle on 14/12/26.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "AppDelegate.h"
#import "UIHelper.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "SOLocationManager.h"
#import "SOLoginManager.h"
#import "HWLoginViewController.h"
#import "WXApi.h"
#import "API.h"
#import "HW_StartPage_ViewController.h"

#define kCurrentVersionTutorial @"1.0.0" //假如下次需要引导时候，修改这个KEY

@interface AppDelegate ()<RDVTabBarControllerDelegate,WXApiDelegate>
{
    AFNetworkReachabilityStatus _reachabilityStatus;
    NSInteger _seleteSection;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.hidden = FALSE;
    
    self.tabBarController = [UIHelper tabBarControllertWithIndex:2];
    self.tabBarController.delegate = self;
    UINavigationController *tabBarNavigation = [UIHelper navigationControllerViewController:self.tabBarController];
    tabBarNavigation.navigationBarHidden = TRUE;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.rootViewController = tabBarNavigation;
    [self.window makeKeyAndVisible];
    
    [[SOLocationManager shareInstance] autoLocationService];
    
    [WXApi registerApp:kWXAPPID withDescription:@"youfan"];
    
    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:.8f] ];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    _reachabilityStatus = AFNetworkReachabilityStatusUnknown;
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kCurrentVersionTutorial]) {
        
        HW_StartPage_ViewController *startPageViewController = [[HW_StartPage_ViewController alloc] initWithNibName:@"HW_StartPage_ViewController" bundle:nil];
        
        [tabBarNavigation pushViewController:startPageViewController animated:NO];
     
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kCurrentVersionTutorial];
    }
    
    
    return YES;

}


#pragma mark
#pragma mark  RDVTabBarControllerDelegate

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    _seleteSection = [tabBarController.viewControllers indexOfObject:viewController];
    
    if (_seleteSection == TabBarControllerUser) {
        if (![SOLoginManager shareInstance].hasLogin) {
            HWLoginViewController *loginViewController = [[HWLoginViewController alloc] initWithNibName:@"HWLoginViewController" bundle:nil];
            loginViewController.target = self;
            loginViewController.method = @selector(loginSucces:);
            [UIHelper tabController:tabBarController presentSubController:loginViewController];
            
            return FALSE;
            
        }
        
        
    }
    
    return TRUE;
}

- (void)loginSucces:(id)sender
{
    self.tabBarController.selectedIndex = _seleteSection;
}



//微信回调

-(void) onReq:(BaseReq*)req
{

}

-(void) onResp:(BaseResp*)resp
{
  if([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *temp = (SendAuthResp*)resp;
        [[SOLoginManager shareInstance] wxUnionLoginRespon:temp];
    }else if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        
        NSString *strMsg = nil;
        
        if (resp.errCode == WXSuccess) {
            strMsg = @"分享成功";
        }else{
            strMsg = @"分享失败";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}




- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
