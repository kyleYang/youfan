//
//  HotActivity.m
//  youfan
//
//  Created by Kyle on 15/1/1.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "HotActivity.h"

#define kActivityId @"activityId"
#define kActivityName @"activityName"
#define kActivityPic @"activityPic"
#define kLastSign_memberNo @"lastSign_memberNo"
#define kLastSign_time @"lastSign_time"
#define kLastSign_nickName @"lastSign_nickName"
#define kLastSign_headImg @"lastSign_headImg"

@implementation HotActivity


+(HotActivity *)objectWithDictionary:(NSDictionary *)dic
{
    if (dic == nil || ![dic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"HotActivity objectWithDictionary:%@",dic);
        return nil;
    }
    
    HotActivity *activity = [[HotActivity alloc] init];
    activity.activityId = [[dic objectForKey:kActivityId] integerValue];
    activity.activityName = [dic objectForKey:kActivityName];
    activity.activityPic = [dic objectForKey:kActivityPic];
    activity.lastSign_memberNo = [dic objectForKey:kLastSign_memberNo];
    activity.lastSign_time = [dic objectForKey:kLastSign_time];
    activity.lastSign_nickName = [dic objectForKey:kLastSign_nickName];
    activity.lastSign_headImg = [dic objectForKey:kLastSign_headImg];
    
    return activity;
    
    
}
+(NSArray *)parseWidthArray:(NSArray *)array
{
    return nil;
    
}


@end
