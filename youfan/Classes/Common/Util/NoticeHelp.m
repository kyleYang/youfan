//
//  NoticeHelp.m
//  eShop
//
//  Created by Kyle on 14/10/22.
//  Copyright (c) 2014年 yujiahui. All rights reserved.
//

#import "NoticeHelp.h"

#define kErrMsgKey @"msg"

@implementation NoticeHelp



+ (void)showChoiceAlertInViewController:(UIViewController *)viewController
                                  title:(NSString *)title
                                message:(NSString *)message
                               tapBlock:(void (^)(NSInteger buttonIndex))tapBlock
{
    [NoticeHelp showAlertInViewController:viewController withTitle:title message:message cancelButtonTitle:NSLocalizedStringFromTable(@"button.cancel", @"commonlib", nil) destructiveButtonTitle:nil otherButtonTitles:@[NSLocalizedStringFromTable(@"button.ok", @"commonlib", nil)] tapBlock:tapBlock];
    
}


+ (void)showChoiceAlertInViewController:(UIViewController *)viewController
                                message:(NSString *)message
                               tapBlock:(void (^)(NSInteger buttonIndex))tapBlock
{
    [NoticeHelp showAlertInViewController:viewController withTitle:nil message:message cancelButtonTitle:NSLocalizedStringFromTable(@"button.cancel", @"commonlib", nil) destructiveButtonTitle:nil otherButtonTitles:@[NSLocalizedStringFromTable(@"button.ok", @"commonlib", nil)] tapBlock:tapBlock];
}


+ (void)showSureAlertInViewController:(UIViewController *)viewController
                              message:(NSString *)message
{
     [NoticeHelp showAlertInViewController:viewController withTitle:nil message:message cancelButtonTitle:NSLocalizedStringFromTable(@"button.ok", @"commonlib", nil) destructiveButtonTitle:nil otherButtonTitles:nil tapBlock:nil];
}

+ (void)showSureAlertInViewController:(UIViewController *)viewController
                              message:(NSString *)message
                            tapBlock:(void (^)(NSInteger buttonIndex))tapBlock
{
    [NoticeHelp showAlertInViewController:viewController withTitle:nil message:message cancelButtonTitle:NSLocalizedStringFromTable(@"button.ok", @"commonlib", nil) destructiveButtonTitle:nil otherButtonTitles:nil tapBlock:tapBlock];
}



+ (void)showAlertInViewController:(UIViewController *)viewController
                        withTitle:(NSString *)title
                          message:(NSString *)message
                cancelButtonTitle:(NSString *)cancelButtonTitle
           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                otherButtonTitles:(NSArray *)otherButtonTitles
                         tapBlock:(void (^)(NSInteger buttonIndex))tapBlock
{
    if ([UIAlertController class]) {
        [UIAlertController showAlertInViewController:viewController
                                           withTitle:title message:message
                                   cancelButtonTitle:cancelButtonTitle
                              destructiveButtonTitle:destructiveButtonTitle
                                   otherButtonTitles:otherButtonTitles
                                            tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                                
                                                if (destructiveButtonTitle == nil) {
                                                    
                                                    NSInteger tempIndex = buttonIndex;
                                                    if (tempIndex > UIAlertControllerBlocksCancelButtonIndex) {
                                                        tempIndex =  tempIndex - UIAlertControllerBlocksDestructiveButtonIndex;
                                                    }
                                                    
                                                    if (tapBlock) {
                                                        tapBlock(tempIndex);
                                                    }
                                                }else {
                                                    
                                                    if (tapBlock) {
                                                        tapBlock(buttonIndex);
                                                    }
                                                }
                                            }];
    } else {
        NSMutableArray *other = [NSMutableArray array];
        
        if (destructiveButtonTitle) {
            [other addObject:destructiveButtonTitle];
        }
        
        if (otherButtonTitles) {
            [other addObjectsFromArray:otherButtonTitles];
        }
        
        [UIAlertView showWithTitle:title
                           message:message
                 cancelButtonTitle:cancelButtonTitle
                 otherButtonTitles:other
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
                              if (tapBlock) {
                                  if (buttonIndex == alertView.cancelButtonIndex) {
                                      tapBlock(UIAlertControllerBlocksCancelButtonIndex);
                                  } else if (destructiveButtonTitle) {
                                      if (buttonIndex == alertView.firstOtherButtonIndex) {
                                          tapBlock(UIAlertControllerBlocksDestructiveButtonIndex);
                                      } else if (otherButtonTitles.count) {
                                          NSInteger otherOffset = buttonIndex - alertView.firstOtherButtonIndex;
                                          tapBlock(UIAlertControllerBlocksFirstOtherButtonIndex + otherOffset - 1);
                                      }
                                  } else if (otherButtonTitles.count) {
                                      NSInteger otherOffset = buttonIndex - alertView.firstOtherButtonIndex;
                                      
                                      tapBlock(UIAlertControllerBlocksDestructiveButtonIndex + otherOffset);
                                  }
                              }
                          }];
    }
}





@end
