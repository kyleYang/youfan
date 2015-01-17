//
//  Env.h
//  CommonLib
//
//  Created by Kyle on 14-10-11.
//  Copyright (c) 2014年 yujiahui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>

#define kStandardWidth 320.0f

typedef NS_ENUM(NSInteger, DeviceVersion){
    iPhone4 = 3,
    iPhone4S = 4,
    iPhone5 = 5,
    iPhone5C = 5,
    iPhone5S = 6,
    iPhone6 = 7,
    iPhone6Plus = 8,
    
    iPad1 = 109,
    iPad2 = 110,
    iPadMini = 111,
    iPad3 = 112,
    iPad4 = 113,
    iPadAir = 115,
    iPadMiniRetina = 116,
    Simulator = 0
};

typedef NS_ENUM(NSInteger, DeviceSize){
    iPhone35inch = 1,    //iphone4 iphone4s
    iPhone4inch = 2,    //iphone5
    iPhone47inch = 3,  //iphone6
    iPhone55inch = 4  //iphone6Plus
};


@interface Env : NSObject



@property (nonatomic, readonly) NSUInteger systemMajorVersion; //系统版本号
@property (nonatomic, readonly) DeviceSize deviceSize;
@property (nonatomic, readonly) CGSize screenSize;
@property (nonatomic, readonly) CGFloat screenWidth;

+(instancetype)shareEnv;

+(DeviceVersion)deviceVersion;
+(DeviceSize)deviceSize;
+(NSString*)deviceName;


@end
