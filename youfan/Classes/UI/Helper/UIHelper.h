//
//  UIHelper.h
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, TabBarControllerType)
{
    TabBarControllerHome = 0,
    TabBarControllerFriend,
    TabBarControllerDinner,
    TabBarControllerOrder,
    TabBarControllerUser,
    TabBarControllerTotal
};

@interface UIHelper : NSObject

+(RDVTabBarController *)tabBarControllertWithIndex:(NSUInteger)index;

+(UINavigationController *)navigationControllerViewController:(UIViewController *)controller;

+(void)tabController:(UIViewController *)tabController pushSubController:(UIViewController *)subViewController;
+(void)tabController:(UIViewController *)tabController presentSubController:(UIViewController *)subViewController;

+(void)viewController:(UIViewController *)viewController pushSubController:(UIViewController *)subViewController;




@end
