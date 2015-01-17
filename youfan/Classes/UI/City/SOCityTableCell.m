//
//  SOCityTableCell.m
//  youfan
//
//  Created by Kyle on 15/1/1.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "SOCityTableCell.h"

@implementation SOCityTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        _cityLabel = [UILabel autolayoutView];
        _cityLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:_cityLabel];
        
        _seleteImageView = [UIImageView autolayoutView];
        _seleteImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_seleteImageView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_cityLabel,_seleteImageView);
        NSDictionary *metrics = @{@"seleteWith":@25};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-25-[_cityLabel]->=40-[_seleteImageView(seleteWith)]-20-|" options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom metrics:metrics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_cityLabel]-5-|" options:0 metrics:metrics views:views]];
        
    }
    
    return self;
    
}

@end
