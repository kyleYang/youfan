//
//  NSString+Util.h
//  youfan
//
//  Created by Kyle on 15/1/2.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Util)

+ (BOOL)isEmpty:(NSString*)str;
+ (NSString *)convertKeyAndValueFrom:(NSDictionary*)parameters;

- (BOOL)isEqualTo:(NSString *)element;
- (BOOL) contains:(NSString*)str;
- (NSString *)converForJsonOfIos;
- (NSString*)md5Convert;
- (NSString*)md5From:(NSUInteger)location atLen:(NSUInteger)len;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
- (NSString *)GBKEncode;
- (NSString *)GBKDecode;

@end
