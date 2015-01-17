//
//  ListHeadView.m
//  youfan
//
//  Created by 123 on 15-1-16.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "ListHeadView.h"
#import "Util.h"


@interface ListHeadView()



@end
@implementation ListHeadView

-(instancetype)initAutoLayout{

    if(self = [super init])
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIImageView *background = [UIImageView autolayoutView];
        background.userInteractionEnabled = NO;
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
        
        
        UIButton* backButton=[UIButton autolayoutView];
        [backButton setBackgroundImage:[UIImage imageNamed:@"arrow_button_normal"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backto:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        
//        UIButton *scanButton = [UIButton autolayoutView];
//        [scanButton setBackgroundImage:[UIImage imageNamed:@"home_scan"] forState:UIControlStateNormal];
//        [scanButton addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:scanButton];
//        
//        UILabel *scanLabel = [UILabel autolayoutView];
//        scanLabel.font = [UIFont systemFontOfSize:14.0f];
//        scanLabel.textColor = HexRGB(0xf6a780);
//        scanLabel.text = NSLocalizedString(@"home.scan", nil);
//        [self addSubview:scanLabel];
//        
//        UIButton *searhButton = [UIButton autolayoutView];
//        searhButton.backgroundColor = [UIColor redColor];
//        [self addSubview:searhButton];
//        
//        
//        NSDictionary *views = NSDictionaryOfVariableBindings(background,_cityLabel,downButton,scanButton,scanLabel,searhButton,backButton);
//        NSDictionary *metrics = @{@"downwidht":@16,@"scanwidth":@40,@"backwidth":@35,@"searchheight":@25,@"searhwidth":@180};
//        
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[background]|" options:0 metrics:metrics views:views]];
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[background]|" options:0 metrics:metrics views:views]];
//        
//        
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-120-[_cityLabel]-10-[downButton(downwidht)]->=65-[scanButton(scanwidth)]-25-|" options:0 metrics:metrics views:views]];
//        
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:downButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_cityLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:1.0]];
//
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_cityLabel]-2-[backButton]" options:0 metrics:metrics views:views]];
//        [self addConstraints:[NSLayoutConstraint
//                              constraintsWithVisualFormat:@"|-5-[backButton(backwidth)]-10-[searhButton]" options:0 metrics:metrics views:views]];
//        
//        
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:scanButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_cityLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:10.0f]];
//        
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[_cityLabel]-2-[searhButton(searchheight)]" options:0 metrics:metrics views:views]];
//        
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-55-[searhButton(searhwidth)]" options:0 metrics:metrics views:views]];
//        
//        
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:scanLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:scanButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:3]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:scanLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:scanButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        
        
    NSDictionary *views = NSDictionaryOfVariableBindings(background,_cityLabel,downButton,backButton);
    NSDictionary *metrics = @{@"downwidht":@16,@"scanwidth":@40,@"backwidth":@35,@"searchheight":@25,@"searhwidth":@180};
        
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[background]|" options:0 metrics:metrics views:views]];
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[background]|" options:0 metrics:metrics views:views]];
        
        
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|->=120-[_cityLabel]-10-[downButton(downwidht)]" options:0 metrics:metrics views:views]];
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_cityLabel]" options:0 metrics:metrics views:views]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:downButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_cityLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:1.0]];
        
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[backButton]" options:0 metrics:metrics views:views]];
                [self addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"|-5-[backButton(backwidth)]" options:0 metrics:metrics views:views]];

    }
    
    
    return self;
}

- (void)citySelectAction:(id)sender
{
//    if ([self.delegate respondsToSelector:@selector(homeHeadViewCitySelete:)]) {
//        [self.delegate listHeadViewCitySelete:self];
//    }
}

- (void)scanAction:(id)sender
{
//    if ([self.delegate respondsToSelector:@selector(homeHeadViewScanning:)]) {
//        [self.delegate listHeadViewScanning:self];
//    }
}

- (void)listHeadViewCitySelete:(ListHeadView *)view
{
//    SOCityViewController *cityController = [[SOCityViewController alloc]    initWithNibName:nil bundle:nil];
//    [UIHelper tabController:self pushSubController:cityController];
    
}


-(void)backto:(id)sender{
    if ([self.delegate respondsToSelector:@selector(backtoMain:)]) {
        [self.delegate backtoMain:self];
    }
}


@end
