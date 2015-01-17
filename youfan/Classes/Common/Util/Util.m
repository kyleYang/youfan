//
//  Util.m
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "Util.h"

@implementation Util

+(NSString *)stringForTimeInterval:(NSTimeInterval)time
{
    if (time == 0) {
        return @"未签到";
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd hh:mm"];
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time/1000]];
}


@end
