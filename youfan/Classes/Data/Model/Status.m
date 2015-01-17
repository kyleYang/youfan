//
//  Status.m
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "Status.h"

#define kRetcode @"retcode"
#define kRetMsg @"retmsg"

@implementation Status

- (NSString *)description
{
    return [NSString stringWithFormat:@"[Status code:%ld, msg:%@]",self.retcode,self.retmsg];
}

+(instancetype)shareStatus
{
    Status *status = [[Status alloc] init];
    status.retcode = FALSE;
    status.retmsg = @"";
    return status;
}

+(instancetype)parseDictionary:(NSDictionary *)dic
{
    Status *status = [Status shareStatus];
    status.retcode = [[dic objectForKey:kRetcode] boolValue];
    status.retmsg = [dic objectForKey:kRetMsg];
    return status;
}


@end
