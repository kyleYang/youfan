//
//  SOBaseNetwork.m
//  youfan
//
//  Created by Kyle on 14/12/26.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOBaseNetwork.h"
#import "SOHttpClient.h"

@implementation SOBaseNetwork

- (AFHTTPRequestOperationManager *)AFHttpWebJsonRequestManager
{
    AFHTTPRequestOperationManager *manager =  [SOHttpClient shareWebHTTPJsonRequestManager];
    return manager;
}


- (AFHTTPRequestOperationManager *)AFHttpWebXmlRequestManager
{
    AFHTTPRequestOperationManager *manager =  [SOHttpClient shareWebHTTPXmlRequestManager];
    return manager;
}


- (AFHTTPRequestOperationManager *)AFHttpMobileJsonRequestManager
{
    AFHTTPRequestOperationManager *manager =  [SOHttpClient shareMobileHTTPJsonRequestManager];
    return manager;
}


@end
