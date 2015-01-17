//
//  HotShop.m
//  youfan
//
//  Created by Kyle on 15/1/1.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "HotShop.h"


#define kShopId @"shopId"
#define kShopName @"shopName"
#define kShopPic @"shopPic"
#define kLastSign_memberNo @"lastSign_memberNo"
#define kLastSign_time @"lastSign_time"
#define kLastSign_nickName @"lastSign_nickName"
#define kLastSign_headImg @"lastSign_headImg"

@implementation HotShop

+(HotShop *)objectWithDictionary:(NSDictionary *)dic
{
    if (dic == nil || ![dic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"HotShop objectWithDictionary:%@",dic);
        return nil;
    }
    
    HotShop *shop = [[HotShop alloc] init];
    shop.shopId = [[dic objectForKey:kShopId] integerValue];
    shop.shopName = [dic objectForKey:kShopId];
    shop.shopPic = [dic objectForKey:kShopPic];
    shop.lastSign_memberNo = [dic objectForKey:kLastSign_memberNo];
    shop.lastSign_time = [dic objectForKey:kLastSign_time];
    shop.lastSign_nickName = [dic objectForKey:kLastSign_nickName];
    shop.lastSign_headImg = [dic objectForKey:kLastSign_headImg];
    
    return shop;
    
    
}


+(NSArray *)parseWidthArray:(NSArray *)array
{
    return nil;
    
}



@end
