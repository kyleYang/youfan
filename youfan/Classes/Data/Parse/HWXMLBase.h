//
//  HWXMLBase.h
//  youfan
//
//  Created by Kyle on 15/1/2.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWXMLBase : NSObject<NSXMLParserDelegate>

@property (nonatomic, assign) BOOL retcode;
@property (nonatomic, copy) NSString *retmsg;

@end
