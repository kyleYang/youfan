//
//  SOBaseNetwork.h
//  youfan
//
//  Created by Kyle on 14/12/26.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API.h"

typedef void(^ESNetworkSuccess)(NSString *msg);
typedef void(^ESNetworkFail)(NSString *error);

@class AFHTTPRequestOperation;
@class AFHTTPRequestOperationManager;

@interface SOBaseNetwork : NSObject


- (AFHTTPRequestOperationManager *)AFHttpWebJsonRequestManager;

- (AFHTTPRequestOperationManager *)AFHttpMobileJsonRequestManager;

- (AFHTTPRequestOperationManager *)AFHttpWebXmlRequestManager;

@end
