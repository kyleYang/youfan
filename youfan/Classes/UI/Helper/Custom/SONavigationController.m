//
//  SONavigationController.m
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SONavigationController.h"

@interface SONavigationController ()

@end

@implementation SONavigationController

- (UIStatusBarStyle)preferredStatusBarStyle
{

    
    if ([self respondsToSelector:@selector(preferredStatusBarStyle)]) {
        return [self.topViewController preferredStatusBarStyle];
    }
    
    return UIStatusBarStyleDefault;
    
}

// New Autorotation support.
- (BOOL)shouldAutorotate{
    
    
    if ([self respondsToSelector:@selector(shouldAutorotate)]) {
        
        return [self.topViewController shouldAutorotate];
    }
    
    return NO;
    
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([self respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [self.topViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    
    if ([self respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)]) {
        
        return [self.topViewController preferredInterfaceOrientationForPresentation];
        
    }
    return UIInterfaceOrientationPortrait;
}


@end
