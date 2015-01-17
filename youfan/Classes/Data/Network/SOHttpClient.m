//
//  SOHttpClient.m
//  youfan
//
//  Created by Kyle on 14/12/26.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOHttpClient.h"

@implementation SOHttpClient




+(AFHTTPRequestOperationManager *)shareWebHTTPJsonRequestManager
{
    static AFHTTPRequestOperationManager *_shareHTTPRequest;
    
    static dispatch_once_t requestToken;
    dispatch_once(&requestToken, ^{
        _shareHTTPRequest = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KWebHostSite]];
        _shareHTTPRequest.requestSerializer = [AFJSONRequestSerializer serializer];
        _shareHTTPRequest.responseSerializer = [AFJSONResponseSerializer serializer];
        _shareHTTPRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
    });
    
    return _shareHTTPRequest;
    
}

+(AFHTTPRequestOperationManager *)shareMobileHTTPJsonRequestManager
{
    static AFHTTPRequestOperationManager *_shareTHMLHTTPRequest;
    
    static dispatch_once_t requestToken;
    dispatch_once(&requestToken, ^{
        _shareTHMLHTTPRequest = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KAPPHostSite]];
        _shareTHMLHTTPRequest.requestSerializer = [AFJSONRequestSerializer serializer];
        _shareTHMLHTTPRequest.responseSerializer = [AFJSONResponseSerializer serializer];
        _shareTHMLHTTPRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
    });
    
    return _shareTHMLHTTPRequest;
    
}


+(AFHTTPRequestOperationManager *)shareWebHTTPXmlRequestManager
{
    static AFHTTPRequestOperationManager *_shareWebXMLHTTPRequest;
    
    static dispatch_once_t requestToken;
    dispatch_once(&requestToken, ^{
        _shareWebXMLHTTPRequest = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KWebHostSite]];
        _shareWebXMLHTTPRequest.requestSerializer = [AFJSONRequestSerializer serializer];
        _shareWebXMLHTTPRequest.responseSerializer = [AFXMLParserResponseSerializer serializer];
        
    });
    
    return _shareWebXMLHTTPRequest;
    
}





@end
