//
//  ESErrorView.m
//  eShop
//
//  Created by Kyle on 14-10-11.
//  Copyright (c) 2014年 yujiahui. All rights reserved.
//

#import "ESErrorView.h"
#import "UIView+Corner.h"
#import "Util.h"

@interface ESErrorView()

@property (nonatomic, strong) UIImageView *errorImage;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UIButton *actionButton;

@end


@implementation ESErrorView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = HexRGB(0xeeeeee);
        
        _errorImage = [UIImageView autolayoutView];
        _errorImage.userInteractionEnabled = TRUE;
        [self addSubview:_errorImage];
        
        _noticeLabel = [UILabel autolayoutView];
        _noticeLabel.numberOfLines = 0;
        _noticeLabel.font = [UIFont systemFontOfSize:14.0f];
        _noticeLabel.textColor = HexRGB(0x757575);
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_noticeLabel];
        
        _actionButton = [UIButton autolayoutView];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_actionButton addTarget:self action:@selector(touchEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_actionButton setSelfLayerCornerRadius:2.0f];
        [_actionButton setBackgroundImage:[UIImage imageNamed:@"bar_buttom_button_normal"] forState:UIControlStateNormal];
        [_actionButton setBackgroundImage:[UIImage imageNamed:@"bar_buttom_button_hilight"] forState:UIControlStateHighlighted];
        [self addSubview:_actionButton];
        
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_errorImage,_noticeLabel,_actionButton);
        NSDictionary *metrics = @{@"imageWidth":@100,@"imageHeight":@100,@"buttonWidth":@100,@"buttonHeight":@35};
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_errorImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_errorImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-20]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_errorImage(imageWidth)]-[_noticeLabel]-8-[_actionButton(buttonHeight)]" options:NSLayoutFormatAlignAllCenterX metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_errorImage(imageWidth)]" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_noticeLabel(200)]" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_actionButton(imageWidth)]" options:0 metrics:metrics views:views]];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchEvent:)];
        [self addGestureRecognizer:tapGesture];
    }
    
    return self;
}



#pragma mark -----------
#pragma makr property
//- (void)setErrorType:(ErrorType)errorType
//{
//    if (_errorType == errorType) {
//        return;
//    }
//    
//    _errorType = errorType;
//    
//    switch (_errorType) {
//        case NetworkError:
//        {
//            _errorImage.image = [UIImage imageNamed:@"error_network_fail"];
//            [_actionButton setTitle:NSLocalizedStringFromTable(@"button.refresh", @"commonlib", nil) forState:UIControlStateNormal];
//            _actionButton.hidden = FALSE;
//            _noticeLabel.text = NSLocalizedString(@"error.notice.network.fail", nil);
//        }
//            
//            break;
//        case NetworkFail:
//        {
//            _errorImage.image = [UIImage imageNamed:@"error_network_fail"];
//            [_actionButton setTitle:NSLocalizedStringFromTable(@"button.refresh", @"commonlib", nil) forState:UIControlStateNormal];
//            _actionButton.hidden = FALSE;
//           _noticeLabel.text = NSLocalizedString(@"error.notice.network.fail", nil);
//        }
//            
//            break;
//        case ShopEmpty:
//        {
//            _errorImage.image = [UIImage imageNamed:@"error_car_empty"];
//            _noticeLabel.text = NSLocalizedString(@"error.notice.car.empty", nil);
//             _actionButton.hidden = FALSE;
//            [_actionButton setTitle:NSLocalizedStringFromTable(@"button.brower", @"commonlib", nil) forState:UIControlStateNormal];
//            
//        }
//            break;
//        case OrderEmpty:
//        {
//            _errorImage.image = [UIImage imageNamed:@"error_order_empty"];
//            _actionButton.hidden = TRUE;
//            _noticeLabel.text = NSLocalizedString(@"error.notice.order.empty", nil);
//
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//}



#pragma mark ----------
#pragma mark method


- (void)touchEvent:(UITapGestureRecognizer *)recognizer
{
    if ([self.delegate respondsToSelector:@selector(ESErrorViewTouch:errorType:)]) {
        [self.delegate ESErrorViewTouch:self errorType:_errorType];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end



