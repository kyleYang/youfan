//
//  ListHeadView.h
//  youfan
//
//  Created by 123 on 15-1-16.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ListHeadViewDelegate;

@interface ListHeadView : UIView

@property (nonatomic, strong) UIButton *cityLabel;
@property (nonatomic, strong) UILabel *locaionLabel;

@property (nonatomic, weak_delegate) id<ListHeadViewDelegate> delegate;
- (instancetype)initAutoLayout;

@end


@protocol ListHeadViewDelegate <NSObject>

- (void)listHeadViewCitySelete:(ListHeadView *)view;
- (void)listHeadViewSearch:(ListHeadView *)view;
- (void)listHeadViewScanning:(ListHeadView *)view;
- (void)backtoMain:(ListHeadView*)view;

@end
