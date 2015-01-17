//
//  SVProgressHelp.m
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SVProgressHelp.h"
#import "SVProgressHUD.h"

@implementation SVProgressHelp


+ (void)showHUD
{
    [SVProgressHUD showProgress:-1 status:nil maskType:SVProgressHUDMaskTypeNone];
}
+ (void)showHUDWithStatus:(NSString *)msg
{
    [SVProgressHUD showProgress:-1 status:msg maskType:SVProgressHUDMaskTypeNone];
    
}


+ (void)showHUDImage:(UIImage *)image status:(NSString *)msg
{
    [SVProgressHUD showImage:image status:msg];
}

+ (void)dismissHUD
{
    [SVProgressHUD dismiss];
}

+ (void)dismissWithMsg:(NSString *)msg
{
    [self dismissWithImage:nil msg:msg];
}


+ (void)dismissWithImage:(UIImage *)image msg:(NSString *)msg
{
    [SVProgressHUD showImage:image status:msg];
}

+ (void)dismissHUDSuccess:(NSString *)msg
{
    [SVProgressHUD showSuccessWithStatus:msg];
}
+ (void)dismissHUDError:(NSString *)msg
{
    [SVProgressHUD showErrorWithStatus:msg];
}



@end
