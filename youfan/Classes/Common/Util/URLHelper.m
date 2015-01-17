//
//  URLHelper.m
//  youfan
//
//  Created by Kyle on 15/1/3.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "URLHelper.h"
#import "API.h"

@implementation URLHelper

+(NSURL *)friendUrlWithDid:(NSString *)did shopId:(NSString *)shopId memberNo:(NSString *)memberNo
{
    
    NSString *stringURL = [NSString stringWithFormat:FRIEND_URL_FORMAT,KAPPHostSite,did==nil?@"":did,shopId==nil?@"":shopId,memberNo==nil?@"":memberNo];
    
    return [NSURL URLWithString:stringURL];
    
}

+ (NSURL *)accountWithDid:(NSString *)did shopId:(NSString *)shopId memberNo:(NSString *)memberNo
{
    NSString *stringURL = [NSString stringWithFormat:ACCOUNT_URL_FORMAT,KAPPHostSite,did==nil?@"":did,shopId==nil?@"":shopId,memberNo==nil?@"":memberNo];
    
    return [NSURL URLWithString:stringURL];
}


+(NSURL *)dinnerUrlWithDid:(NSString *)did shopId:(NSString *)shopId memberNo:(NSString *)memberNo
{
    
    NSString *stringURL = [NSString stringWithFormat:DINNER_URL_FORMAT,KAPPHostSite,did==nil?@"":did,shopId==nil?@"":shopId,memberNo==nil?@"":memberNo];
    
    return [NSURL URLWithString:stringURL];
    
}


+(NSURL *)userCenterWithDid:(NSString *)did memberNo:(NSString *)memberNo
{
    
    NSString *stringURL = [NSString stringWithFormat:USERCENTER_URL_FORMAT,KAPPHostSite,memberNo==nil?@"":memberNo];
    
    return [NSURL URLWithString:stringURL];
}



@end
