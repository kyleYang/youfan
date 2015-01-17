//
//  SOHttpClient.h
//  youfan
//
//  Created by Kyle on 14/12/26.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "API.h"

@interface SOHttpClient : NSObject



+(AFHTTPRequestOperationManager *)shareMobileHTTPJsonRequestManager;
+(AFHTTPRequestOperationManager *)shareWebHTTPXmlRequestManager;
+(AFHTTPRequestOperationManager *)shareWebHTTPJsonRequestManager;

@end
