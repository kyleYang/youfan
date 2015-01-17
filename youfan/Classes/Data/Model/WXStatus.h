//
//  WXStatus.h
//  eShop
//
//  Created by Kyle on 14/12/5.
//  Copyright (c) 2014年 yujiahui. All rights reserved.
//

#import "BaseObject.h"




@interface WXStatus : BaseObject

@property (nonatomic, assign) BOOL status;
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *msg;

+(WXStatus *)objectWithDictionary:(NSDictionary *)dic;
@end
