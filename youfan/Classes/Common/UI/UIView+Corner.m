//
//  UIView+Corner.m
//  eShop
//
//  Created by Kyle on 14/11/3.
//  Copyright (c) 2014年 yujiahui. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView(Corner)


- (void)setCornerOnTopRadius:(CGFloat)radius{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setCornerOnBottomRadius:(CGFloat)radius {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}
- (void)setAllCornerRadius:(CGFloat)radius {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                          cornerRadius:radius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}

- (void)setSelfLayerCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = TRUE;
}


- (void)setLayerWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    self.clipsToBounds = TRUE;
    
}


- (void)setNoneCorner{
    self.layer.mask = nil;
}

@end
