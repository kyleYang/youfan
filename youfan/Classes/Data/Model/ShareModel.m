//
//  ShareModel.m
//  youfan
//
//  Created by Kyle on 15/1/13.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "ShareModel.h"

#define kTitle @"title"
#define kUrl @"url"
#define kDes @"des"
#define kImage @"image"

@implementation ShareModel


+(ShareModel *)objectWithDictionary:(NSDictionary *)dic
{
    if (dic == nil || ![dic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"HotActivity objectWithDictionary:%@",dic);
        return nil;
    }
    
    ShareModel *share = [[ShareModel alloc] init];
    share.title = [dic objectForKey:kTitle];
    share.url = [dic objectForKey:kUrl];
    share.des = [dic objectForKey:kDes];
    share.image = [dic objectForKey:kImage];
    
    return share;

    
}

@end
