//
//  URLHelper.h
//  youfan
//
//  Created by Kyle on 15/1/3.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLHelper : NSObject


+(NSURL *)friendUrlWithDid:(NSString *)did shopId:(NSString *)shopId memberNo:(NSString *)memberNo;
+(NSURL *)accountWithDid:(NSString *)did shopId:(NSString *)shopId memberNo:(NSString *)memberNo;
+(NSURL *)dinnerUrlWithDid:(NSString *)did shopId:(NSString *)shopId memberNo:(NSString *)memberNo;
+(NSURL *)userCenterWithDid:(NSString *)did memberNo:(NSString *)memberNo;
@end
