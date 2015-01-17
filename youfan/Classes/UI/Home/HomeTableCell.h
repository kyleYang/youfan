//
//  HomeTableCell.h
//  youfan
//
//  Created by Kyle on 15/1/1.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface HomeTableCell : UITableViewCell


@property (nonatomic, strong, readonly) UIImageView *iconImageView;
@property (nonatomic, strong, readonly) UIImageView *typeIconView;
@property (nonatomic, strong, readonly) UILabel *typeNameLabel;
@property (nonatomic, strong, readonly) UILabel *productNameLabel;
@property (nonatomic, strong, readonly) UIImageView *singIconView;
@property (nonatomic, strong, readonly) UILabel *singNameLable;
@property (nonatomic, strong, readonly) UILabel *singTimeLabel;

@end
