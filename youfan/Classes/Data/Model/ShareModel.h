//
//  ShareModel.h
//  youfan
//
//  Created by Kyle on 15/1/13.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "BaseObject.h"

@interface ShareModel : BaseObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *image;


+(ShareModel *)objectWithDictionary:(NSDictionary *)dic;

@end
