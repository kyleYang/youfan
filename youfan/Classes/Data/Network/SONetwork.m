//
//  SONetwork.m
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SONetwork.h"
#import "AFNetworking.h"
#import "Status.h"
#import "HotRepast.h"
#import "HotShop.h"
#import "HotProduct.h"
#import "HotActivity.h"
#import "NSString+Util.h"
#import "SOLoginManager.h"


@implementation SONetwork
{
    AFHTTPRequestOperation *_homeOpration;
    AFHTTPRequestOperation *_wxtokenOperation;
    AFHTTPRequestOperation *_wxUseInfoOperation;
    AFHTTPRequestOperation *_wxUionLoginOperation;
    AFHTTPRequestOperation *_shareMessageOpration;
}
- (AFHTTPRequestOperation *)homeRefreshThreeCode:(NSString *)code Success:(arraySuccess)success fail:(ESNetworkFail)fail
{
    
    if (_homeOpration != nil) {
        NSLog(@"homeRefreshSuccess  _homeOpration = %@",_homeOpration);
        return _homeOpration;
    }
    
    NSDictionary *parameters = @{@"method":@"initIndex",@"cityCode":code};
    
    
    AFHTTPRequestOperationManager *manager = [self AFHttpMobileJsonRequestManager];
    _homeOpration = [manager GET:kHomePageURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"goodsHomeRefreshSuccess operation:%@\n responseObject:%@",operation,responseObject);
        _homeOpration = nil;
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        Status *status = [Status parseDictionary:responseDictionary];
        if (!status.retcode) {
            fail(status.retmsg);
            return;
        }
        
        HotShop *hotShop = [HotShop objectWithDictionary:[responseDictionary objectForKey:@"hotShop"]];
        HotProduct *hotProduct = [HotProduct objectWithDictionary:[responseDictionary objectForKey:@"hotProduct"]];
        HotActivity *hotActivity = [HotActivity objectWithDictionary:[responseDictionary objectForKey:@"hotActivity"]];
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
        if (hotShop != nil) {
            [array addObject:hotShop];
        }
        if (hotProduct != nil) {
            [array addObject:hotProduct];
        }
        if (hotActivity != nil) {
            [array addObject:hotActivity];
        }

        success(array);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"goodsHomeRefreshFailure operation:%@\n error:%@",operation,error);
        _homeOpration = nil;
        fail([error localizedDescription]);
    }];
    return _homeOpration;
    
}

-(AFHTTPRequestOperation *)ListRefreshwithCode:(NSString *)citycode withkeyWord:(NSString *)keyWord withStartIndex:(NSString *)startIndex withPageSize:(NSString *)pageSize withLat:(NSString *)lat_init withLng:(NSString *)lng_init Success:(arraySuccess)success fail:(ESNetworkFail)fail{
    
    if (_homeOpration != nil) {
        NSLog(@"homeRefreshSuccess  _homeOpration = %@",_homeOpration);
        return _homeOpration;
    }
    
    NSDictionary *parameters = @{@"method":@"shopSearch",@"cityCode":citycode,@"keyWord":keyWord,@"startIndex":startIndex,@"pageSize":pageSize,@"lat_init":lat_init,@"lng_init":lng_init};
 
    AFHTTPRequestOperationManager *manager = [self AFHttpMobileJsonRequestManager];
    _homeOpration = [manager GET:kHomePageURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"ListRefreshSuccess operation:%@\n responseObject:%@",operation,responseObject);
        _homeOpration = nil;
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        Status *status = [Status parseDictionary:responseDictionary];
        if (!status.retcode) {
            fail(status.retmsg);
            return;
        }
        
        NSArray * list=[responseDictionary objectForKey:@"shopList"];
        NSLog(@"lsit------%@",list);
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:100];
        for(int i=0; i<[list count];i++){
            NSDictionary* listdic=[list objectAtIndex:i];
            HotRepast * repast=[HotRepast objectWithDictionary:listdic];
            if(repast!=nil){

                [array addObject:repast];
            }
        }
        
        success(array);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"goodsHomeRefreshFailure operation:%@\n error:%@",operation,error);
        _homeOpration = nil;
        fail([error localizedDescription]);
    }];
    return _homeOpration;
}

- (void)loginWithUsername:(NSString *)userName andPwd:(NSString*)password parser:(HWLoginParser *)loginparser success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail
{
    //手机唯一标志符
    NSString* openUDID = [[NSUserDefaults standardUserDefaults] stringForKey: @"sourceID"];
    if([NSString isEmpty:openUDID])
    {
        openUDID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        openUDID = [@"orangeios" stringByAppendingString:openUDID];
        [[NSUserDefaults standardUserDefaults] setObject:openUDID forKey:@"sourceID"];
    }
    
    NSString *md5Password = [password md5From:1 atLen:16];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userName forKey:@"ipt_DUserAccount"];
    [parameters setObject:md5Password forKey:@"ipt_DUserPasswd"];
    [parameters setObject:openUDID forKey:@"sourceID"];
    
    AFHTTPRequestOperationManager *manager = [self AFHttpWebXmlRequestManager];
    
    [manager GET:LOGIN_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"loginWithUsername operation :%@ ,responseObject :%@",operation,responseObject);
        NSXMLParser *parser = (NSXMLParser *)responseObject;
        
        parser.delegate = loginparser;
        [parser parse];
        [SOLoginManager shareInstance].loginStatus = loginparser.loginResult;
        
        
        if (!loginparser.retcode) {
            success(loginparser.retmsg);
            return ;
        }
        
        success(@"登录成功");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"loginWithUsername operation :%@ ,errror :%@",operation,error);
        fail([error localizedDescription]);
    }];
    
}


- (void)getVerifyCode:(NSString *)mobile parser:(HWVerifyCodeParser *)verfyParser success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail

{
    [self requestOneVerifyCodeFor:mobile ResetPwd:NO parser:verfyParser success:success fail:fail];
}


- (void)requestOneVerifyCodeFor:(NSString *)mobile ResetPwd:(BOOL)resetPwd parser:(HWVerifyCodeParser *)verfyParser success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail

{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"code" forKey:@"act"];
    [parameters setObject:mobile forKey:@"mobile"];
    if (resetPwd)
    {
        [parameters setObject:@"resetPassword" forKey:@"buss"];
    }
    
    
    AFHTTPRequestOperationManager *manager = [self AFHttpWebXmlRequestManager];
    
    [manager GET:VERYFY_CODE_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"loginWithUsername operation :%@ ,responseObject :%@",operation,responseObject);
        NSXMLParser *parser = (NSXMLParser *)responseObject;
        
        parser.delegate = verfyParser;
        [parser parse];

        if (!verfyParser.retcode) {
            fail(verfyParser.retmsg);
            return;
        }
        
        success(@"验证码获取成功");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"loginWithUsername operation :%@ ,errror :%@",operation,error);
        fail([error localizedDescription]);
    }];
    
}


- (void)goRegister:(NSString*)password Mobile:(NSString*)mobile VerifyCode:(NSString*)vcode InviteNo:(NSString*)inviteNo parase:(HWRegisterParser *)registerParaser success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *md5Password = [password md5From:1 atLen:16];
    [parameters setObject:md5Password forKey:@"password"];
    [parameters setObject:mobile forKey:@"mobile"];
    [parameters setObject:vcode forKey:@"verifyNo"];
    [parameters setObject:@"mobileRegister" forKey:@"method"];
    if (inviteNo)
    {
        [parameters setObject:inviteNo forKey:@"invitNo"];
    }
    else
    {
        [parameters setObject:@"" forKey:@"invitNo"];
    }
    
    
     AFHTTPRequestOperationManager *manager = [self AFHttpWebXmlRequestManager];
    
    [manager GET:REGISTER_USER_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"goRegister operation :%@ ,responseObject :%@",operation,responseObject);
        NSXMLParser *parser = (NSXMLParser *)responseObject;
        
        parser.delegate = registerParaser;
        [parser parse];

        if (!registerParaser.retcode) {
            fail(registerParaser.retmsg);
            return;
        }
        
        success(@"注册成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"goRegister operation :%@ ,errror :%@",operation,error);
        fail([error localizedDescription]);
    }];
    
    
}


- (void)resetPassword:(NSString*)newPassword Mobile:(NSString*)mobile VerifyCode:(NSString*)vcode parser:(HWResetPasswordParser *)resetParser success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *md5Password = [newPassword md5From:1 atLen:16];
    [parameters setObject:md5Password forKey:@"password"];
    [parameters setObject:mobile forKey:@"mobile"];
    [parameters setObject:vcode forKey:@"verifyNo"];
    [parameters setObject:@"resetPassword" forKey:@"method"];
  
    
    AFHTTPRequestOperationManager *manager = [self AFHttpWebXmlRequestManager];
    [manager GET:RESET_PWD_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"goRegister operation :%@ ,responseObject :%@",operation,responseObject);
        NSXMLParser *parser = (NSXMLParser *)responseObject;
        
        parser.delegate = resetParser;
        [parser parse];
        
        if (!resetParser.retcode) {
            fail(resetParser.retmsg);
            return;
        }
        
        success(@"修改密码成功");

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"goRegister operation :%@ ,errror :%@",operation,error);
        fail([error localizedDescription]);
        
    }];
    

}


- (AFHTTPRequestOperation *)getWechatAccessTokenAPPid:(NSString *)appid appSecret:(NSString *)secret code:(NSString *)code success:(dicSuccess)success fail:(ESNetworkFail)fail
{
    if (_wxtokenOperation != nil) {
        NSLog(@"getWechatAccessTokenAPPid  _wxtokenOperation = %@",_wxtokenOperation);
        return _wxtokenOperation;
    }
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kWeChatHost]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"]; //微信需要是 text/plain
    
    NSDictionary *parameters = @{@"grant_type":@"authorization_code",@"appid":appid,@"secret":secret,@"code":code};
    
    _wxtokenOperation = [manager GET:kWeChatAccessTokenURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"getWechatAccessTokenAPPid operation:%@\n responseObject:%@",operation,responseObject);
        _wxtokenOperation = nil;
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        WXStatus *status = [WXStatus objectWithDictionary:responseDictionary];
        if (!status.status) {
            fail(status.msg);
            return;
        }
        
        success(responseDictionary);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"clearCollectSuccess operation:%@\n error:%@",operation,error);
        _wxtokenOperation = nil;
        fail([error localizedDescription]);
    }];
    return _wxtokenOperation;
    
}


- (AFHTTPRequestOperation *)getWechatUserInfoAccess_token:(NSString *)access_token openid:(NSString *)openid success:(dicSuccess)success fail:(ESNetworkFail)fail
{
    if (_wxUseInfoOperation != nil) {
        NSLog(@"getWechatUserInfoAccess_token  _wxUseInfoOperation = %@",_wxUseInfoOperation);
        return _wxUseInfoOperation;
    }
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kWeChatHost]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"]; //微信需要是 text/plain
    
    NSDictionary *parameters = @{@"access_token":access_token,@"openid":openid};
    
    _wxtokenOperation = [manager GET:kWeChatUserInfoURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"getWechatAccessTokenAPPid operation:%@\n responseObject:%@",operation,responseObject);
        _wxtokenOperation = nil;
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        WXStatus *status = [WXStatus objectWithDictionary:responseDictionary];
        if (!status.status) {
            fail(status.msg);
            return;
        }
        
        success(responseDictionary);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"clearCollectSuccess operation:%@\n error:%@",operation,error);
        _wxtokenOperation = nil;
        fail([error localizedDescription]);
    }];
    return _wxtokenOperation;
    
}


- (AFHTTPRequestOperation *)wxLoginWithOpenId:(NSString *)openID nickName:(NSString *)nickName headImgURL:(NSString *)headImgURL unionId:(NSString *)unionID sex:(NSString *)sex city:(NSString *)city province:(NSString *)province success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail
{
    
    
    
    if (_wxUionLoginOperation != nil) {
        NSLog(@"wxLoginWithOpenId  _wxUionLoginOperation = %@",_wxUionLoginOperation);
        return _wxUseInfoOperation;
    }
    
    AFHTTPRequestOperationManager *manager = [self AFHttpMobileJsonRequestManager];



    NSDictionary *parameters = @{@"method":@"loginWeixin",@"openId":openID==nil?@"":openID,@"nickName":nickName==nil?@"":nickName,@"headImgUrl":headImgURL==nil?@"":headImgURL,@"unionId":unionID==nil?@"":unionID,@"sex":sex==nil?@"1":sex,@"city":city==nil?@"":city,@"province":province==nil?@"":province};
    
    _wxUionLoginOperation = [manager GET:kWXUnionLoginURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"getWechatAccessTokenAPPid operation:%@\n responseObject:%@",operation,responseObject);
        _wxUionLoginOperation = nil;
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        WXStatus *status = [WXStatus objectWithDictionary:responseDictionary];
        if (!status.status) {
            fail(status.msg);
            return;
        }
        
        NSString *memberNo = [responseDictionary objectForKey:@"memberNo"];
        if (memberNo == nil) {
            memberNo = @"";
        }
        
        success(memberNo);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"clearCollectSuccess operation:%@\n error:%@",operation,error);
        _wxUionLoginOperation = nil;
        fail([error localizedDescription]);
    }];
    return _wxUionLoginOperation;
    
}


- (AFHTTPRequestOperation *)wxShareMessageType:(NSString *)type valueId:(NSString *)vId username:(NSString *)name success:(getShreSuccess)success fail:(ESNetworkFail)fail
{
    if (_shareMessageOpration != nil) {
        NSLog(@"wxShareMessageType  _shareMessageOpration = %@",_shareMessageOpration);
        return _shareMessageOpration;
    }
    
 
    
    NSDictionary *parameters = @{@"method":@"weixinShare",@"memberNo":(name==nil?@"":name),@"type":type,@"id":vId};
    
    
    AFHTTPRequestOperationManager *manager = [self AFHttpWebJsonRequestManager];
    _shareMessageOpration = [manager GET:kWebWXShareMessageULR parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"goodsHomeRefreshSuccess operation:%@\n responseObject:%@",operation,responseObject);
        _shareMessageOpration = nil;
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        Status *status = [Status parseDictionary:responseDictionary];
        if (!status.retcode) {
            fail(status.retmsg);
            return;
        }
        
        ShareModel *model = [ShareModel objectWithDictionary:responseDictionary];
        
        
        success(model);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"goodsHomeRefreshFailure operation:%@\n error:%@",operation,error);
        _shareMessageOpration = nil;
        fail([error localizedDescription]);
    }];
    return _shareMessageOpration;

    
}



- (void)logout
{
    

    
    AFHTTPRequestOperationManager *manager = [self AFHttpWebXmlRequestManager];

    NSDictionary *parameters = @{@"method":@"removeSession"};
    
    [manager GET:LOGOUT_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    

}



@end
