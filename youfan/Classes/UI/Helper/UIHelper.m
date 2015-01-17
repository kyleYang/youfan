//
//  UIHelper.m
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "UIHelper.h"
#import "SOHomeViewController.h"
#import "SOFriendViewController.h"
#import "SODinnerViewController.h"
#import "SOSettingViewController.h"
#import "SONavigationController.h"
#import "SOTabBarController.h"
#import "RDVTabBarItem.h"
#import "SOOrderViewController.h"
#import "SOAccountViewController.h"

@implementation UIHelper


+(RDVTabBarController *)tabBarControllertWithIndex:(NSUInteger)index
{
    UIViewController *homeController = [[SOHomeViewController alloc] initWithNibName:nil bundle:nil];
    
    UIViewController *friendController = [[SOFriendViewController alloc] initWithConfiguration:nil];
    UINavigationController *friendNavi = [[SONavigationController alloc]
                                               initWithRootViewController:friendController];
    
    UIViewController *dinnerController = [[SODinnerViewController alloc] initWithConfiguration:nil];
    UINavigationController *dinnderNavi = [[SONavigationController alloc]
                                              initWithRootViewController:dinnerController];
    
    UIViewController *accountContrller = [[SOAccountViewController alloc] initWithConfiguration:nil];
    UINavigationController *accountNavi = [[SONavigationController alloc]
                                           initWithRootViewController:accountContrller];
    
    UIViewController *settingController = [[SOSettingViewController alloc] initWithConfiguration:nil];
    UINavigationController *settingNavi = [[SONavigationController alloc]
                                           initWithRootViewController:settingController];
    
    
    
    SOTabBarController *tabBarController = [[SOTabBarController alloc] init]; //对status bar 能定制
    [tabBarController setViewControllers:@[dinnderNavi,friendNavi,homeController,accountNavi,settingNavi]];
    
    
    
    
    NSArray *tabBarItemImages = @[@"cate_home", @"cate_friend",@"cate_dinner",@"cate_order",@"cate_user"];
    NSArray *tabBarHightImages = @[@"cate_home_hilight",@"cate_friend_hilight",@"cate_dinner_hilight",@"cate_order_hilight",@"cate_user_hilight"];
    
    NSInteger i = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        item.backgroundColor = [UIColor whiteColor];
        UIImage *selectedimage = [UIImage imageNamed:[tabBarHightImages objectAtIndex:i]];
        UIImage *unselectedimage = [UIImage imageNamed:[tabBarItemImages objectAtIndex:i]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setUnselectedTitleAttributes:@{
                                             NSFontAttributeName: [UIFont systemFontOfSize:10],
                                             NSForegroundColorAttributeName: HexRGB(0X9a9a9a),
                                             }];
        [item setSelectedTitleAttributes:@{
                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:10],
                                           NSForegroundColorAttributeName: HexRGB(0XFF760b),
                                           }];
        
        i++;
    }
    
    
    tabBarController.selectedIndex = index;
    
    
//    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
//                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
//                                                           nil]];
//    //    [[UINavigationBar appearance] setTranslucent:YES];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"type_bg"]
//                                       forBarMetrics:UIBarMetricsDefault];
//    [UINavigationBar appearance].shadowImage = [UIImage new];
//    
//    NSLog(@"--------set navigation bar--------");
//    //    [[UINavigationBar appearance] setBarTintColor:HexRGBA(0xff0066,.5)];
//    //    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
//
//    
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                          [UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:16.0f],NSFontAttributeName,
//                                                          nil] forState:UIControlStateNormal];
//    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                          HexRGB(0x000000), NSForegroundColorAttributeName,[UIFont systemFontOfSize:16.0f],NSFontAttributeName,
//                                                          nil] forState:UIControlStateHighlighted];
//    
//    //    UIImage *image = [[UIImage imageNamed:@"bar_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
//    //    UIImage *downimage = [[UIImage imageNamed:@"bar_back_down"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
//    //
//    //    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return tabBarController;

}


+(UINavigationController *)navigationControllerViewController:(UIViewController *)controller
{
    if ([controller isKindOfClass:[UINavigationController class]]) {
        NSLog(@"navigationControllerViewController controller isKindOfClass");
        return (UINavigationController *)controller;
    }
    UINavigationController *navi = [[SONavigationController alloc] initWithRootViewController:controller];
    return navi;
}


+(void)tabController:(UIViewController *)tabController pushSubController:(UIViewController *)subViewController
{
//    tabController.rdv_tabBarController.navigationController.navigationBarHidden = FALSE;
    [tabController.rdv_tabBarController.navigationController pushViewController:subViewController animated:YES];
  
}


+(void)tabController:(UIViewController *)tabController presentSubController:(UIViewController *)subViewController
{
    UINavigationController *navi = [[SONavigationController alloc] initWithRootViewController:subViewController];
    
    [tabController presentViewController:navi animated:YES completion:^{
        
    }];
    
}
+(void)viewController:(UIViewController *)viewController pushSubController:(UIViewController *)subViewController
{
    [viewController.navigationController pushViewController:subViewController animated:YES];
}


@end
