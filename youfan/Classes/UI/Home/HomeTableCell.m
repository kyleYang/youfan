//
//  HomeTableCell.m
//  youfan
//
//  Created by Kyle on 15/1/1.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "HomeTableCell.h"
#import "Util.h"
#import "UIView+Corner.h"

@interface HomeTableCell()

@property (nonatomic, strong, readwrite) UIImageView *iconImageView;
@property (nonatomic, strong, readwrite) UIImageView *typeIconView;
@property (nonatomic, strong, readwrite) UILabel *typeNameLabel;
@property (nonatomic, strong, readwrite) UILabel *productNameLabel;
@property (nonatomic, strong, readwrite) UIImageView *singIconView;
@property (nonatomic, strong, readwrite) UILabel *singNameLable;
@property (nonatomic, strong, readwrite) UILabel *singTimeLabel;

@end




@implementation HomeTableCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _iconImageView = [UIImageView autolayoutView];
        [_iconImageView setLayerWithCornerRadius:3.0f borderWidth:1.0f borderColor:[UIColor whiteColor]];
        [self.contentView addSubview:_iconImageView];
        
        UIImageView *typeBgImageView = [UIImageView autolayoutView];
        typeBgImageView.image = [[UIImage imageNamed:@"type_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 15, 1, 5)];
        [_iconImageView addSubview:typeBgImageView];
        
        _typeNameLabel = [UILabel autolayoutView];
        _typeNameLabel.font = [UIFont systemFontOfSize:14.0f];
        _typeNameLabel.textColor = HexRGB(0xb51f10);
        [typeBgImageView addSubview:_typeNameLabel];
        
        
        UIImageView *bgImageView = [UIImageView autolayoutView];
        bgImageView.image = [UIImage imageNamed:@"sing_bg"];
        [_iconImageView addSubview:bgImageView];
        
        _typeIconView = [UIImageView autolayoutView];
        [bgImageView addSubview:_typeIconView];
        
        
        _productNameLabel = [UILabel autolayoutView];
        _productNameLabel.font = [UIFont systemFontOfSize:14.0f];
        _productNameLabel.textColor = HexRGB(0x726554);
        [bgImageView addSubview:_productNameLabel];
        
        _singIconView = [UIImageView autolayoutView];
        [_singIconView setLayerWithCornerRadius:10.0f borderWidth:1.0f borderColor:[UIColor whiteColor]];
        [bgImageView addSubview:_singIconView];
        
        _singNameLable = [UILabel autolayoutView];
        _singNameLable.font = [UIFont systemFontOfSize:14.0f];
        _singNameLable.textColor = HexRGB(0x726554);
        [bgImageView addSubview:_singNameLable];
        
        _singTimeLabel = [UILabel autolayoutView];
        _singTimeLabel.font = [UIFont systemFontOfSize:13.0f];
        _singTimeLabel.textColor = HexRGB(0x666666);
        [bgImageView addSubview:_singTimeLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_iconImageView,typeBgImageView,_typeNameLabel,bgImageView,_typeIconView,_productNameLabel,_singIconView,_singNameLable,_singTimeLabel);
        NSDictionary *meterics = @{@"typeBgImageViewWidht":@100,@"typeBgImageViewHeight":@18,@"singHight":@25};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-25-[_iconImageView]-25-|" options:0 metrics:meterics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_iconImageView]-5-|" options:0 metrics:meterics views:views]];
        
        [_iconImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[typeBgImageView(>=typeBgImageViewWidht)]" options:0 metrics:meterics views:views]];
        [_iconImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-9-[typeBgImageView(typeBgImageViewHeight)]" options:0 metrics:meterics views:views]];
        
        [typeBgImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-5-[_typeNameLabel]" options:0 metrics:meterics views:views]];
        [typeBgImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_typeNameLabel]|" options:0 metrics:meterics views:views]];
        
        
        [_iconImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bgImageView]|" options:0 metrics:meterics views:views]];
        [_iconImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bgImageView(singHight)]|" options:0 metrics:meterics views:views]];
        
    
        [bgImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-6-[_typeIconView]-6-[_productNameLabel(55)]->=10-[_singIconView(20)]-8-[_singNameLable(50)]-4-[_singTimeLabel(80)]-5-|" options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom metrics:meterics views:views]];
        [bgImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[_productNameLabel]-3-|" options:0 metrics:meterics views:views]];
    }
    
    return self;
}

@end
