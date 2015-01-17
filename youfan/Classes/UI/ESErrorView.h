//
//  ESErrorView.h
//  eShop
//
//  Created by Kyle on 14-10-11.
//  Copyright (c) 2014年 yujiahui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ErrorType)
{
    NetworkUnknow = 0,
    NetworkError = 1,
    NetworkFail = 2,
    ShopEmpty = 50,
    OrderEmpty = 51
};


@protocol ErrorViewDelegate;

@interface ESErrorView : UIView

@property (nonatomic, readonly) UIImageView *errorImage;
@property (nonatomic, readonly) UILabel *noticeLabel;
@property (nonatomic, readonly) UIButton *actionButton;


@property (nonatomic, weak_delegate) id<ErrorViewDelegate>delegate;
@property (nonatomic, assign) ErrorType errorType;

@end



@protocol ErrorViewDelegate <NSObject>

@required
- (void)ESErrorViewTouch:(ESErrorView *)view errorType:(ErrorType)errorType;

@end