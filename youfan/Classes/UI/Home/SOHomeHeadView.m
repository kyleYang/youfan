//
//  SOHOmeHeadView.m
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOHomeHeadView.h"
#import "Util.h"

@interface SOHomeHeadView()



@end


@implementation SOHomeHeadView

- (instancetype)initAutoLayout
{
    if(self = [super init])
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIImageView *background = [UIImageView autolayoutView];
        background.userInteractionEnabled = YES;
        background.image = [UIImage imageNamed:@"head_bg"];
        [self addSubview:background];
        
        
        _cityLabel = [UIButton autolayoutView];
        _cityLabel.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_cityLabel setTitleColor:HexRGB(0xf6a780) forState:UIControlStateNormal];
        [_cityLabel setTitle:@"深圳" forState:UIControlStateNormal ] ;
        [_cityLabel addTarget:self action:@selector(citySelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cityLabel];

        UIButton *downButton = [UIButton autolayoutView];
        [downButton setBackgroundImage:[UIImage imageNamed:@"down_icon"] forState:UIControlStateNormal];
        [downButton addTarget:self action:@selector(citySelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:downButton];
  
        UIButton *locationButton = [UIButton autolayoutView];
        [locationButton addTarget:self action:@selector(relocattionAction:) forControlEvents:UIControlEventTouchUpInside];
        [locationButton setBackgroundImage:[UIImage imageNamed:@"location_head_icon"] forState:UIControlStateNormal];
        [self addSubview:locationButton];
        
        _locaionLabel = [UIButton autolayoutView];
        _locaionLabel.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_locaionLabel setTitleColor:HexRGB(0x767676) forState:UIControlStateNormal];
        [_locaionLabel setTitle:NSLocalizedString(@"home.near.restaurant", nil) forState:UIControlStateNormal];
        [_locaionLabel addTarget:self action:@selector(relocattionAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_locaionLabel];
        
        
        
        
        
        UIButton *scanButton = [UIButton autolayoutView];
        [scanButton setBackgroundImage:[UIImage imageNamed:@"home_scan"] forState:UIControlStateNormal];
        [scanButton addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:scanButton];
        
        UILabel *scanLabel = [UILabel autolayoutView];
        scanLabel.font = [UIFont systemFontOfSize:14.0f];
        scanLabel.textColor = HexRGB(0xf6a780);
        scanLabel.text = NSLocalizedString(@"home.scan", nil);
        [self addSubview:scanLabel];
        
//        UIButton *searhButton = [UIButton autolayoutView];
//        searhButton.backgroundColor = [UIColor redColor];
//        [self addSubview:searhButton];
        
        
        NSDictionary *views = NSDictionaryOfVariableBindings(background,_cityLabel,downButton,locationButton,_locaionLabel,scanButton,scanLabel);
        NSDictionary *metrics = @{@"downwidht":@16,@"scanwidth":@40,@"locaionWidht":@10,@"searchheight":@25,@"searhwidth":@180};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[background]|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[background]|" options:0 metrics:metrics views:views]];

        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_cityLabel]-10-[downButton(downwidht)]->=40-[locationButton(locaionWidht)]-5-[_locaionLabel]-40-[scanButton(scanwidth)]-15-|" options:0 metrics:metrics views:views]];
        
          [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-35-[_cityLabel]" options:0 metrics:metrics views:views]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:downButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_cityLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:1.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:locationButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_cityLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:1.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_locaionLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_cityLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:1.0]];
      [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[scanButton]" options:0 metrics:metrics views:views]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:scanButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_cityLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:10.0f]];
        
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_cityLabel]-2-[searhButton(searchheight)]" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];
//        
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[searhButton(searhwidth)]" options:0 metrics:metrics views:views]];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:scanLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:scanButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:3]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:scanLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:scanButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        
        
    }
    
    
    return self;
    
}




- (void)cityGestrue:(UIGestureRecognizer *)recognizer
{
    if ([self.delegate respondsToSelector:@selector(homeHeadViewCitySelete:)]) {
        [self.delegate homeHeadViewCitySelete:self];
    }
}

- (void)citySelectAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(homeHeadViewCitySelete:)]) {
        [self.delegate homeHeadViewCitySelete:self];
    }
}

- (void)relocattionAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(homeHeadViewRelocation:)]) {
        [self.delegate homeHeadViewRelocation:self];
    }
}

- (void)scanAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(homeHeadViewScanning:)]) {
        [self.delegate homeHeadViewScanning:self];
    }
    
}


@end
