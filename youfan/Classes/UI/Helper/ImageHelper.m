//
//  ImageHelper.m
//  youfan
//
//  Created by Kyle on 15/1/17.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "ImageHelper.h"
#import "Env.h"

@implementation ImageHelper


+(UIImage *)imageWithName:(NSString *)name
{
//    iPhone35inch = 1,    //iphone4 iphone4s
//    iPhone4inch = 2,    //iphone5
//    iPhone47inch = 3,  //iphone6
//    iPhone55inch = 4
    
    
    NSString *realName = name;
    
    switch ([Env shareEnv].deviceSize) {
        case iPhone35inch:
            break;
        case iPhone4inch:
            realName = [NSString stringWithFormat:@"%@-568",name];
            break;
        case iPhone47inch:
            realName = [NSString stringWithFormat:@"%@-667",name];
            break;
        case iPhone55inch:
            realName = [NSString stringWithFormat:@"%@-736",name];
            break;
        default:
            break;
    }
    
    UIImage *image = [UIImage imageNamed:realName];
    
    if (image == nil) {
    
        
        image = [UIImage imageNamed:name];
        
        if (image == nil) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-568",name]];
        }
        
        if (image == nil) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-667",name]];
        }
        
        if (image == nil) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-736",name]];
        }
        
        
    }
    
    
    return image;
    
}

@end
