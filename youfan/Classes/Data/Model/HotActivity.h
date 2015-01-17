//
//  HotActivity.h
//  youfan
//
//  Created by Kyle on 15/1/1.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "BaseObject.h"

@interface HotActivity : BaseObject

@property (nonatomic, assign) NSInteger activityId;
@property (nonatomic, copy) NSString *activityName;
@property (nonatomic, copy) NSString *activityPic;
@property (nonatomic, copy) NSString *lastSign_memberNo;
@property (nonatomic, copy) NSString *lastSign_time;
@property (nonatomic, copy) NSString *lastSign_nickName;
@property (nonatomic, copy) NSString *lastSign_headImg;


+(HotActivity *)objectWithDictionary:(NSDictionary *)dic;
+(NSArray *)parseWidthArray:(NSArray *)array;

@end
