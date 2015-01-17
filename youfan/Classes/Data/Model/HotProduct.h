//
//  HotProduct.h
//  youfan
//
//  Created by Kyle on 15/1/1.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "BaseObject.h"

@interface HotProduct : BaseObject

@property (nonatomic, assign) NSInteger productId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productPic;
@property (nonatomic, copy) NSString *lastSign_memberNo;
@property (nonatomic, copy) NSString *lastSign_time;
@property (nonatomic, copy) NSString *lastSign_nickName;
@property (nonatomic, copy) NSString *lastSign_headImg;


+(HotProduct *)objectWithDictionary:(NSDictionary *)dic;
+(NSArray *)parseWidthArray:(NSArray *)array;

@end
