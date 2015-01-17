//
//  UIView+Corner.h
//  eShop
//
//  Created by Kyle on 14/11/3.
//  Copyright (c) 2014年 yujiahui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Corner)


- (void)setCornerOnTopRadius:(CGFloat)radius;

- (void)setCornerOnBottomRadius:(CGFloat)radius;

- (void)setAllCornerRadius:(CGFloat)radius;

- (void)setSelfLayerCornerRadius:(CGFloat)radius;

- (void)setLayerWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

- (void)setNoneCorner;

@end
