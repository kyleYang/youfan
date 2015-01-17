//
//  UIView+AutoLayout.m
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView(AutoLayout)

+(instancetype)autolayoutView
{
    UIView *view = [self new];
    view.backgroundColor = [UIColor clearColor];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

@end
