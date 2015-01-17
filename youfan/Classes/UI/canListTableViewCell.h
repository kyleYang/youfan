//
//  canListTableViewCell.h
//  youfan
//
//  Created by 123 on 15-1-14.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface canListTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UIImageView *iconImageView;
@property (nonatomic, strong, readonly) UIImageView *priseIconView;
@property (nonatomic, strong, readonly) UIImageView *singIconView;
@property (nonatomic, strong, readonly) UILabel *shopAddressLabel;
@property (nonatomic, strong, readonly) UILabel *shopNameLabel;
@property (nonatomic, strong, readonly) UILabel *singNameLabel;
@property (nonatomic, strong, readonly) UILabel *priseNameLabel;
@property (nonatomic, strong, readonly) UILabel *priceLabel;
@property (nonatomic, strong, readonly) UILabel *foodTypeLabel;
@property (nonatomic, strong, readonly) UILabel *scroeLabel;
@property (nonatomic, strong, readonly) UILabel *distanceLabel;


@end
