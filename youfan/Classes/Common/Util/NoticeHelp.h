//
//  NoticeHelp.h
//  eShop
//
//  Created by Kyle on 14/10/22.
//  Copyright (c) 2014年 yujiahui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIAlertController+Blocks.h"
#import "UIAlertView+Blocks.h"

@interface NoticeHelp : NSObject


+ (void)showChoiceAlertInViewController:(UIViewController *)viewController
                                  title:(NSString *)title
                                message:(NSString *)message
                               tapBlock:(void (^)(NSInteger buttonIndex))tapBlock;

+ (void)showChoiceAlertInViewController:(UIViewController *)viewController
                          message:(NSString *)message
                         tapBlock:(void (^)(NSInteger buttonIndex))tapBlock;

+ (void)showSureAlertInViewController:(UIViewController *)viewController
                              message:(NSString *)message;

+ (void)showSureAlertInViewController:(UIViewController *)viewController
                              message:(NSString *)message
                             tapBlock:(void (^)(NSInteger buttonIndex))tapBlock;

+ (void)showAlertInViewController:(UIViewController *)viewController
                        withTitle:(NSString *)title
                          message:(NSString *)message
                cancelButtonTitle:(NSString *)cancelButtonTitle
           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                otherButtonTitles:(NSArray *)otherButtonTitles
                         tapBlock:(void (^)(NSInteger buttonIndex))tapBlock;



@end
