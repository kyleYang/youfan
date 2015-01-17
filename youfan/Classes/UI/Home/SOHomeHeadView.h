//
//  SOHOmeHeadView.h
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeHeadViewDelegate;

@interface SOHomeHeadView : UIView

@property (nonatomic, strong) UIButton *cityLabel;
@property (nonatomic, strong) UIButton *locaionLabel;

@property (nonatomic, weak_delegate) id<HomeHeadViewDelegate> delegate;

- (instancetype)initAutoLayout;

@end


@protocol HomeHeadViewDelegate <NSObject>

- (void)homeHeadViewCitySelete:(SOHomeHeadView *)view;
- (void)homeHeadViewRelocation:(SOHomeHeadView *)view;
- (void)homeHeadViewSearch:(SOHomeHeadView *)view;
- (void)homeHeadViewScanning:(SOHomeHeadView *)view;


@end

