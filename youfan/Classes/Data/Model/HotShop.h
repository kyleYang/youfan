//
//  HotShop.h
//  youfan
//
//  Created by Kyle on 15/1/1.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "BaseObject.h"

@interface HotShop : BaseObject

@property (nonatomic, assign) NSInteger shopId;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *shopPic;
@property (nonatomic, copy) NSString *lastSign_memberNo;
@property (nonatomic, copy) NSString *lastSign_time;
@property (nonatomic, copy) NSString *lastSign_nickName;
@property (nonatomic, copy) NSString *lastSign_headImg;


+(HotShop *)objectWithDictionary:(NSDictionary *)dic;
+(NSArray *)parseWidthArray:(NSArray *)array;

@end
