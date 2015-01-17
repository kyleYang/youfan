//
//  Status.h
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "BaseObject.h"

@interface Status : BaseObject

@property (nonatomic, assign) BOOL retcode;
@property (nonatomic, copy) NSString *retmsg;

+(instancetype)shareStatus;
+(instancetype)parseDictionary:(NSDictionary *)dic;

@end
