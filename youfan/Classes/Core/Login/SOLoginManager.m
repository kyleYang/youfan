//
//  SOLoginManager.m
//  youfan
//
//  Created by Kyle on 15/1/2.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "SOLoginManager.h"
#import "API.h"
#import "SOHttpClient.h"
#import "NSString+Util.h"

#define kLoginState @"youfan.login"
#define kUserName @"youfan.username"

@implementation SOLoginManager
@synthesize hasLogin = _hasLogin;

static SOLoginManager *_shareInstance = nil;


+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _shareInstance = [[SOLoginManager alloc] init];
       
        
        
    });
    
    return _shareInstance;
    
}


- (instancetype)init
{
    if (self = [super init]) {
    
         _hasLogin = [[NSUserDefaults standardUserDefaults] boolForKey:kLoginState];
        
        if (_hasLogin) {
            _userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
        }
        
        
    }
    
    return self;
    
}



- (BOOL)hasLogin
{
    return _hasLogin;
}

- (NSString *)getLoginUserName
{
    
    return _userName == nil? @"":_userName;

}


- (void)setLoginStatus:(NSMutableDictionary *)loginStatus
{
    _loginStatus = loginStatus;
    
    if (_loginStatus != nil) {
        
        _userName = [_loginStatus objectForKey:@"user"];
        
        _userName = (_userName==nil? @"":_userName);
        _hasLogin = TRUE;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLoginState];
        [[NSUserDefaults standardUserDefaults] setObject:_userName forKey:kUserName];
    }else{
         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLoginState];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kUserName];
    }
    
}


- (void)setWxUserInfo:(NSDictionary *)wxUserInfo
{
    _wxUserInfo = wxUserInfo;
    
    if (_wxUserInfo != nil) {
        
        _userName = [_wxUserInfo objectForKey:@"unionid"];
        _userName = (_userName==nil? @"":_userName);
        _hasLogin = TRUE;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLoginState];
        [[NSUserDefaults standardUserDefaults] setObject:_userName forKey:kUserName];
        
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLoginState];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kUserName];
    }
    
}



- (void)wxUnionLoginRespon:(SendAuthResp *)resq
{
    if ([self.delegate respondsToSelector:@selector(wxLoginRespon:)]) {
        [self.delegate wxLoginRespon:resq];
    }
}


- (NSString *)getLoginUserMobile
{
    NSString *ret = @"";
    
    NSMutableDictionary *userInfo = [self.loginStatus objectForKey:@"u"];
    if (userInfo)
    {
        ret = [userInfo objectForKey:@"mobile"];
    }
    
    return ret;
}

- (NSString *)createCookieStringForXml:(NSDictionary *)infoDict
{
    NSString *ret = @"";
    
    //得到词典中所有KEY值，并按字母表排序
    NSArray * enumeratorKey = [[infoDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in enumeratorKey)
    {
        NSString *value = [infoDict objectForKey:key];
        if ([@"user" isEqualToString:key])
        {
            ret = [ret stringByAppendingFormat:@"%@=%@; ",key, value];
        }
        else
        {
            ret = [ret stringByAppendingFormat:@"domain=%@; path=/, %@=%@; ",kCookieDomainForLogin, key, value];
        }
    }
    
    return ret;
}

- (NSString *)createCookieStringForJson:(NSDictionary *)infoDict
{
    NSString *ret = @"";
    
    //得到词典中所有KEY值，并按字母表排序
    NSArray * enumeratorKey = [[infoDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in enumeratorKey)
    {
        NSString *value = [infoDict objectForKey:key];
        ret = [ret stringByAppendingFormat:@"%@=%@;",key, value];
    }
    
    return ret;
}

- (NSString *)getLoginCookieForXmlClient
{
    NSString *fullCookie = @"";
    
    //添加JSESSIONID
    fullCookie = [fullCookie stringByAppendingFormat:@"%@;",self.JSESSIONID];
    
    NSString *tmp = [self createCookieStringForXml:[self.loginStatus valueForKey:@"cookieMap"]];
    fullCookie = [fullCookie stringByAppendingFormat:@"%@ domain=%@; path=/",tmp,kCookieDomainForLogin];
    return fullCookie;
}

- (NSString *)getLoginCookieForJsonClient
{
    NSString *fullCookie = @"";
    
    //添加JSESSIONID
    fullCookie = [fullCookie stringByAppendingFormat:@"%@;",self.JSESSIONID];
    
    NSString *tmp = [self createCookieStringForJson:[self.loginStatus valueForKey:@"cookieMap"]];
    fullCookie = [fullCookie stringByAppendingFormat:@"%@",tmp];
    return fullCookie;
}

- (void)resetLoginCookieForAFClient
{
    NSString *fullCookie = [self getLoginCookieForXmlClient];
    NSLog(@"xml fullCookie==%@", fullCookie);
    [[SOHttpClient shareWebHTTPXmlRequestManager].requestSerializer setValue:fullCookie forHTTPHeaderField:@"Cookie"];
    fullCookie = [self getLoginCookieForJsonClient];
    NSLog(@"json fullCookie==%@", fullCookie);
    
    [[SOHttpClient shareWebHTTPJsonRequestManager].requestSerializer setValue:fullCookie forHTTPHeaderField:@"Cookie"];
    [[SOHttpClient shareMobileHTTPJsonRequestManager].requestSerializer setValue:fullCookie forHTTPHeaderField:@"Cookie"];
}

//获取行程单类型:0 显示字符串 1 原始数据
- (NSString *)getTravelFormSendType:(NSInteger)valueType
{
    NSString *ret = @"";
    
    NSMutableDictionary *userInfo = [self.loginStatus objectForKey:@"u"];
    NSString *send_type = [userInfo objectForKey:@"send_type"];
    if (1 == valueType)
    {//取原始数据
        ret = send_type;
    }
    else
    {//获取显示使用的字符串
        NSInteger type = [send_type integerValue];
        
        switch (type)
        {
            case 1:
                ret = NSLocalizedString(@"邮寄", @"邮寄");
                break;
            case 2:
                ret = NSLocalizedString(@"机场打印", @"机场打印");
                break;
            case 3:
                ret = NSLocalizedString(@"无需配送", @"无需配送");
                break;
            case 6:
                ret = NSLocalizedString(@"营业部自取", @"营业部自取");
                break;
            default:
                break;
        }
    }
    
    return ret;
}

- (void)setTravelFormSendType:(NSString*)sendTypeValue
{
    NSMutableDictionary *userInfo = [self.loginStatus objectForKey:@"u"];
    if (userInfo)
    {
        [userInfo setObject:sendTypeValue forKey:@"send_type"];
    }
    else
    {
        userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:sendTypeValue forKey:@"send_type"];
    }
}

//机票商旅政策相关
- (BOOL)isBusinessUser
{
    NSDictionary *cookieMap = (NSDictionary*)[self.loginStatus objectForKey:@"cookieMap"];
    NSString *userType = [cookieMap objectForKey:@"custType"];
    if ([@"C" isEqualToString:userType])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSString*)getBusinessPolicyFor:(NSInteger)index
{
    NSDictionary *cookieMap = (NSDictionary*)[self.loginStatus objectForKey:@"cookieMap"];
    NSString *ret = nil;
    if (0 == index)
    {
        ret = [cookieMap objectForKey:@"nh"];
    }
    else if(1 == index)
    {
        ret = [cookieMap objectForKey:@"nd"];
    }
    
    return ret;
}

- (NSString*)getBusinessPolicyForShow:(NSInteger)index
{
    NSDictionary *cookieMap = (NSDictionary*)[self.loginStatus objectForKey:@"cookieMap"];
    NSString *ret = nil;
    if (0 == index)
    {
        ret = [NSString stringWithFormat:@"1.预订起飞前后%@小时最低价机票", [cookieMap objectForKey:@"nh"]];
    }
    else if(1 == index)
    {
        ret = [NSString stringWithFormat:@"2.提前%@天预订机票", [cookieMap objectForKey:@"nd"]];
    }
    
    return ret;
}

- (NSString *)getBusinessCompany
{
    NSString *ret = nil;
    NSDictionary *cookieMap = (NSDictionary*)[self.loginStatus objectForKey:@"cookieMap"];
    ret = [cookieMap objectForKey:@"comName"];
    ret = [ret URLDecodedString];
    
    return ret;
}
- (NSString *)getcomCode
{
    NSString *ret = nil;
    NSDictionary *cookieMap = (NSDictionary*)[self.loginStatus objectForKey:@"cookieMap"];
    ret = [cookieMap objectForKey:@"comCode"];
    ret = [ret URLDecodedString];
    
    return ret;
}


- (NSString *)getBusinessCompanyAndDepart
{
    NSString *ret = nil;
    NSDictionary *cookieMap = (NSDictionary*)[self.loginStatus objectForKey:@"cookieMap"];
    ret = [cookieMap objectForKey:@"comName"];
    ret = [ret stringByAppendingFormat:@"/%@",[cookieMap objectForKey:@"deptName"]];
    ret = [ret URLDecodedString];
    
    return ret;
}

- (NSString *)getBusinessRole
{
    NSString *ret = nil;
    NSDictionary *cookieMap = (NSDictionary*)[self.loginStatus objectForKey:@"cookieMap"];
    ret = [cookieMap objectForKey:@"role"];
    
    return ret;
}

- (NSString *)getBusinessRoleShow
{
    NSString *ret = nil;
    NSDictionary *cookieMap = (NSDictionary*)[self.loginStatus objectForKey:@"cookieMap"];
    ret = [cookieMap objectForKey:@"role"];
    if ([ret isEqualToString:@"SYS"])
    {
        ret = @"系统管理员";
    }
    else if ([ret isEqualToString:@"CS"])
    {
        ret = @"超级审核专员";
    }
    else if ([ret isEqualToString:@"PS"])
    {
        ret = @"普通审核专员";
    }
    else if ([ret isEqualToString:@"YG"])
    {
        ret = @"员工";
    }
    
    return ret;
}





@end
