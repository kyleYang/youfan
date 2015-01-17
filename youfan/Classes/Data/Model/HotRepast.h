//
//  HotRepast.h
//  youfan
//
//  Created by 123 on 15-1-14.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "BaseObject.h"

@interface HotRepast : BaseObject

@property (nonatomic, copy) NSString *shopId;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *shopPic;
@property (nonatomic, copy) NSString *Sign_number;
@property (nonatomic, copy) NSString *Prise_number;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *shopType;
@property (nonatomic, copy) NSString *clientCode;
@property (nonatomic, copy) NSString *avgPrice;

+(HotRepast *)objectWithDictionary:(NSDictionary *)dic;
+(NSArray *)parseWidthArray:(NSArray *)array;

@end
