//
//  WXStatus.m
//  eShop
//
//  Created by Kyle on 14/12/5.
//  Copyright (c) 2014年 yujiahui. All rights reserved.
//

#import "WXStatus.h"

#define kErrcode @"errcode"
#define kErrmsg @"errmsg"
#define kPrepayId @"prepayid"

@implementation WXStatus

+(WXStatus *)objectWithDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"WXToken objectWithDictionary  dic isKindOfClass:NSDictionary");
        return nil;
    }

    
    WXStatus *status = [[WXStatus alloc] init];
    
    id errorCode = [dic objectForKey:kErrcode];
    if (errorCode == nil || [errorCode integerValue] == 0) {
        status.status = TRUE;
        status.prepayid = [dic objectForKey:kPrepayId];
        return status;
        
    }
    status.status = FALSE;
    status.msg = [dic objectForKey:kErrmsg];
    status.code = [[dic objectForKey:kErrcode] integerValue];
    return status;
    
}


@end
