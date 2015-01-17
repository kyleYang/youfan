//
//  SOCodeReaderViewController.m
//  youfan
//
//  Created by Kyle on 15/1/5.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "SOCodeReaderViewController.h"
#import "NoticeHelp.h"
#import "SOScanWebViewController.h"


@interface SOCodeReaderViewController()<QRCodeReaderDelegate>
{
    BOOL _isShowAlter;
}


@end

@implementation SOCodeReaderViewController

- (instancetype)initWithCancelButtonTitle:(NSString *)cancelTitle
{
    if (self = [super initWithCancelButtonTitle:cancelTitle]) {
        
        self.delegate = self;
    
        
    }
    
    return self;
}


- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    
    if (result.length == 0) {
        return ;
    }
    
    
    SOScanWebViewController *scanWebViewController = [[SOScanWebViewController alloc] initWithScanString:result];
    
    __weak typeof(self) weakSelf = self;
    
    [self.navigationController pushViewController:scanWebViewController animated:YES onCompletion:^{
        
        NSMutableArray *afterController = [NSMutableArray array]; //将本页面删除
        NSArray *viewController = weakSelf.navigationController.viewControllers;
        [viewController enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL *stop) {
            
            if (![obj isKindOfClass:[SOCodeReaderViewController class]]) {
                [afterController addObject:obj];
                
            }
            
        }];
        
        self.navigationController.viewControllers = afterController;
        
        
    }];
    
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
