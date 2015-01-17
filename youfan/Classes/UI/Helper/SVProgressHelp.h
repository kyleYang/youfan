//
//  SVProgressHelp.h
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVProgressHelp : NSObject

+ (void)showHUD;

+ (void)showHUDWithStatus:(NSString *)msg;

+ (void)showHUDImage:(UIImage *)image status:(NSString *)msg;

+ (void)dismissHUD;

+ (void)dismissWithMsg:(NSString *)msg;

+ (void)dismissWithImage:(UIImage *)image msg:(NSString *)msg;

+ (void)dismissHUDSuccess:(NSString *)msg;

+ (void)dismissHUDError:(NSString *)msg;

@end
