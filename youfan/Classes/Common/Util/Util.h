//
//  Util.h
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import <Foundation/Foundation.h>


#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HexRGB(hexRGB) [UIColor colorWithRed:((float)((hexRGB & 0xFF0000) >> 16))/255.0 green:((float)((hexRGB & 0xFF00) >> 8))/255.0 blue:((float)(hexRGB & 0xFF))/255.0 alpha:1.0]  //0xFFFFFF
#define HexRGBA(hexRGB,A) [UIColor colorWithRed:((float)((hexRGB & 0xFF0000) >> 16))/255.0 green:((float)((hexRGB & 0xFF00) >> 8))/255.0 blue:((float)(hexRGB & 0xFF))/255.0 alpha:(A)]  //0xFFFFFF

#define IS_IOS7 ([Env shareEnv].systemMajorVersion == 7)
#define IS_IOS8 ([Env shareEnv].systemMajorVersion == 8)
#define IS_IPHONE6PLUS ([Env shareEnv].deviceSize == iPhone55inch)

@interface Util : NSObject

+(NSString *)stringForTimeInterval:(NSTimeInterval)time;

@end
