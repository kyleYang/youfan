//
//  canListTableViewCell.m
//  youfan
//
//  Created by 123 on 15-1-14.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "canListTableViewCell.h"
#import "Util.h"
#import "UIView+Corner.h"

@implementation canListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        _iconImageView = [UIImageView autolayoutView];
        [_iconImageView setLayerWithCornerRadius:3.0f borderWidth:1.0f borderColor:[UIColor whiteColor]];
        _iconImageView.image = [UIImage imageNamed:@"ht_default_icon"];
        [self.contentView addSubview:_iconImageView];
        
        UIImageView *infoView=[UIImageView autolayoutView];
        [self.contentView addSubview:infoView];
        
        _shopNameLabel=[UILabel autolayoutView];
        _shopNameLabel.font = [UIFont systemFontOfSize:14.0f];
        _shopNameLabel.textColor =[UIColor blackColor];
        [infoView addSubview:_shopNameLabel];
        
        _shopAddressLabel=[UILabel autolayoutView];
        _shopAddressLabel.font=[UIFont systemFontOfSize:10.0f];
        _shopAddressLabel.textColor=[UIColor lightGrayColor];
        [infoView addSubview:_shopAddressLabel];
        
        _foodTypeLabel=[UILabel autolayoutView];
        _foodTypeLabel.font=[UIFont systemFontOfSize:12.0f];
        _foodTypeLabel.textColor=[UIColor lightGrayColor];
        [infoView addSubview:_foodTypeLabel];
        
        _priceLabel=[UILabel autolayoutView];
        _priceLabel.font=[UIFont systemFontOfSize:13.0f];
        _priceLabel.textColor=[UIColor lightGrayColor];
        [infoView addSubview:_priceLabel];
        
        _scroeLabel=[UILabel autolayoutView];
        _scroeLabel.font=[UIFont systemFontOfSize:12.0f];
        _scroeLabel.textColor=[UIColor lightGrayColor];
        [infoView addSubview:_scroeLabel];
        
        _priseIconView=[UIImageView autolayoutView];
        _priseIconView.image=[UIImage imageNamed:@"repast_good"];
        [infoView addSubview:_priseIconView];
        
        _priseNameLabel=[UILabel autolayoutView];
        _priseNameLabel.font=[UIFont systemFontOfSize:12.0f];
        _priseNameLabel.textColor=[UIColor lightGrayColor];
        [infoView addSubview:_priseNameLabel];
        
        _singIconView=[UIImageView autolayoutView];
        _singIconView.image=[UIImage imageNamed:@"reapst_eye"];
        [infoView addSubview:_singIconView];
        
        _singNameLabel=[UILabel autolayoutView];
        _singNameLabel.font=[UIFont systemFontOfSize:12.0f];
        _singNameLabel.textColor=[UIColor lightGrayColor];
        [infoView addSubview:_singNameLabel];
        
        _distanceLabel=[UILabel autolayoutView];
        _distanceLabel.font=[UIFont systemFontOfSize:10.0f];
        _distanceLabel.textColor=[UIColor lightGrayColor];
        [infoView addSubview:_distanceLabel];
        
        NSDictionary *views =NSDictionaryOfVariableBindings(_iconImageView,infoView,_shopNameLabel,_priceLabel,_shopAddressLabel,_foodTypeLabel,_priseNameLabel,_scroeLabel,_priseIconView,_priseNameLabel,_singIconView,_singNameLabel,_distanceLabel);
        
        NSDictionary *meterics = @{@"typeBgImageViewWidht":@100,@"typeBgImageViewHeight":@18,@"singHight":@25};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_iconImageView(70)]-10-|" options:0 metrics:meterics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_iconImageView(70)]-5-|" options:0 metrics:meterics views:views]];
        
         [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[infoView(90)]-5-|" options:0 metrics:meterics views:views]];
         [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-75-[infoView]-5-|" options:0 metrics:meterics views:views]];
        
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_shopNameLabel]" options:0 metrics:meterics views:views]];
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_shopNameLabel]-5-[_shopAddressLabel]" options:0 metrics:meterics views:views]];
        
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_shopAddressLabel]" options:0 metrics:meterics views:views]];
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_shopAddressLabel]-5-[_singIconView]" options:0 metrics:meterics views:views]];
        
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_shopNameLabel]->=15-[_scroeLabel]-10-|" options:0 metrics:meterics views:views]];

        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_scroeLabel]-5-[_shopAddressLabel]" options:0 metrics:meterics views:views]];
        
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_singIconView]" options:0 metrics:meterics views:views]];
        
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[_singNameLabel(25)]" options:0 metrics:meterics views:views]];
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_shopAddressLabel]-5-[_singNameLabel]" options:0 metrics:meterics views:views]];
    
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-70-[_priseIconView]" options:0 metrics:meterics views:views]];
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_shopAddressLabel]-5-[_priseIconView]" options:0 metrics:meterics views:views]];
        
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-87-[_priseNameLabel]" options:0 metrics:meterics views:views]];
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_shopAddressLabel]-5-[_priseNameLabel]" options:0 metrics:meterics views:views]];
        
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_priseNameLabel]->=20-[_distanceLabel]-5-|" options:0 metrics:meterics views:views]];
        [infoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_shopAddressLabel]-8-[_distanceLabel]" options:0 metrics:meterics views:views]];

    }
    
    return self;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
