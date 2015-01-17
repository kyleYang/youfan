//
//  SOTabBarController.m
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOTabBarController.h"

@interface SOTabBarController ()

@end

@implementation SOTabBarController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    UIViewController *viewCotroller = [[self viewControllers] objectAtIndex:[self selectedIndex]];
    
    if ([viewCotroller respondsToSelector:@selector(preferredStatusBarStyle)]) {
        
        return [viewCotroller preferredStatusBarStyle];
    }
    
    return UIStatusBarStyleDefault;
    
}

// New Autorotation support.
- (BOOL)shouldAutorotate{
    UIViewController *viewCotroller = [[self viewControllers] objectAtIndex:[self selectedIndex]];
    
    if ([viewCotroller respondsToSelector:@selector(shouldAutorotate)]) {
        
        return [viewCotroller shouldAutorotate];
    }
    
    return NO;
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    UIViewController *viewCotroller = [[self viewControllers] objectAtIndex:[self selectedIndex]];
    
    if ([viewCotroller respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)]) {
        
        return [viewCotroller preferredInterfaceOrientationForPresentation];
    }
    return UIInterfaceOrientationPortrait;
}

@end
