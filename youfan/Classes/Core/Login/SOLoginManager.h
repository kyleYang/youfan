//
//  SOLoginManager.h
//  youfan
//
//  Created by Kyle on 15/1/2.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol loginManager;

@interface SOLoginManager : NSObject

+(instancetype)shareInstance;


@property (nonatomic, weak_delegate) id<loginManager> delegate;

@property (nonatomic, copy) NSMutableDictionary *loginStatus;
@property (nonatomic, strong) NSDictionary *wxUserInfo;
@property (nonatomic, copy) NSString *JSESSIONID;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, assign) BOOL hasLogin;

- (NSString *)getLoginUserName;

- (void)wxUnionLoginRespon:(SendAuthResp *)resq;


@end


@protocol loginManager <NSObject>

- (void)wxLoginRespon:(SendAuthResp *)resq;

@end