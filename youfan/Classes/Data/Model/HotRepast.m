//
//  HotRepast.m
//  youfan
//
//  Created by 123 on 15-1-14.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "HotRepast.h"

#define kShopId @"shopId"
#define kShopName @"shopName"
#define kShopPic @"shopPic"
#define ksignInAmount @"signInAmount"
#define kpraiseAmount @"praiseAmount"
#define kpro @"por"
#define kavgPrice @"avgPrice"
#define kdistance @"distance"
#define kscore @"score"
#define kshopType @"shopType"
#define kclientCode @"clientCode"

@implementation HotRepast

+(HotRepast *)objectWithDictionary:(NSDictionary *)dic
{
    if (dic == nil || ![dic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"HotShop objectWithDictionary:%@",dic);
        return nil;
    }
    
    HotRepast *shop = [[HotRepast alloc] init];
    shop.shopId = [dic objectForKey:kShopId];
    shop.shopName = [dic objectForKey:kShopName];
    shop.shopPic = [dic objectForKey:kShopPic];
    shop.Sign_number = [dic objectForKey:ksignInAmount];
    shop.Prise_number = [dic objectForKey:kpraiseAmount];
    shop.avgPrice = [dic objectForKey:kavgPrice];
    shop.score = [dic objectForKey:kscore];
    shop.shopType=[dic objectForKey:kshopType];
    shop.distance=[dic objectForKey:kdistance];
    shop.address=[dic objectForKey:kpro];
    shop.clientCode=[dic objectForKey:kclientCode];
    return shop;;
  
}

+(NSArray *)parseWidthArray:(NSArray *)array
{
    return nil;
    
}


@end
