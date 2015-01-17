//
//  HotProduct.m
//  youfan
//
//  Created by Kyle on 15/1/1.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "HotProduct.h"


#define kProductId @"productId"
#define kProductName @"productName"
#define kProductPic @"productPic"
#define kLastSign_memberNo @"lastSign_memberNo"
#define kLastSign_time @"lastSign_time"
#define kLastSign_nickName @"lastSign_nickName"
#define kLastSign_headImg @"lastSign_headImg"

@implementation HotProduct


+(HotProduct *)objectWithDictionary:(NSDictionary *)dic
{
    if (dic == nil || ![dic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"HotProduct objectWithDictionary:%@",dic);
        return nil;
    }
    
    HotProduct *product = [[HotProduct alloc] init];
    product.productId = [[dic objectForKey:kProductId] integerValue];
    product.productName = [dic objectForKey:kProductName];
    product.productPic = [dic objectForKey:kProductPic];
    product.lastSign_memberNo = [dic objectForKey:kLastSign_memberNo];
    product.lastSign_time = [dic objectForKey:kLastSign_time];
    product.lastSign_nickName = [dic objectForKey:kLastSign_nickName];
    product.lastSign_headImg = [dic objectForKey:kLastSign_headImg];
    
    return product;
    
    
}
+(NSArray *)parseWidthArray:(NSArray *)array
{
    return nil;
    
}

@end
