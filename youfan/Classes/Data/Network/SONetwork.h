//
//  SONetwork.h
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOBaseNetwork.h"
#import "HWLoginParser.h"
#import "HWRegisterParser.h"
#import "HWVerifyCodeParser.h"
#import "HWResetPasswordParser.h"
#import "WXStatus.h"
#import "ShareModel.h"




typedef void(^arraySuccess)(NSArray *array);
typedef void(^dicSuccess)(NSDictionary *dic);
typedef void(^getShreSuccess)(ShareModel *model);

@interface SONetwork : SOBaseNetwork

- (AFHTTPRequestOperation *)homeRefreshThreeCode:(NSString *)code Success:(arraySuccess)success fail:(ESNetworkFail)fail;

-(AFHTTPRequestOperation *)ListRefreshwithCode:(NSString *)citycode withkeyWord:(NSString*) keyWord withStartIndex:(NSString *)startIndex withPageSize:(NSString*)pageSize withLat:(NSString*)lat_init withLng:(NSString *)lng_init Success:(arraySuccess)success fail:(ESNetworkFail)fail;


- (void)logout;

- (void)loginWithUsername:(NSString *)userName andPwd:(NSString*)password parser:(HWLoginParser *)parser success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail;

- (void)getVerifyCode:(NSString *)mobile parser:(HWVerifyCodeParser *)verfyParser success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail;
- (void)requestOneVerifyCodeFor:(NSString *)mobile ResetPwd:(BOOL)resetPwd parser:(HWVerifyCodeParser *)verfyParser success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail;

- (void)goRegister:(NSString*)password Mobile:(NSString*)mobile VerifyCode:(NSString*)vcode InviteNo:(NSString*)inviteNo parase:(HWRegisterParser *)registerParaser success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail;


- (void)resetPassword:(NSString*)newPassword Mobile:(NSString*)mobile VerifyCode:(NSString*)vcode parser:(HWResetPasswordParser *)resetParser success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail;



//微信

- (AFHTTPRequestOperation *)getWechatAccessTokenAPPid:(NSString *)appid appSecret:(NSString *)secret code:(NSString *)code success:(dicSuccess)success fail:(ESNetworkFail)fail;
- (AFHTTPRequestOperation *)getWechatUserInfoAccess_token:(NSString *)access_token openid:(NSString *)openid success:(dicSuccess)success fail:(ESNetworkFail)fail;

- (AFHTTPRequestOperation *)wxLoginWithOpenId:(NSString *)openID nickName:(NSString *)nickName headImgURL:(NSString *)headImgURL unionId:(NSString *)unionID sex:(NSString *)sex city:(NSString *)city province:(NSString *)province success:(ESNetworkSuccess)success fail:(ESNetworkFail)fail;


- (AFHTTPRequestOperation *)wxShareMessageType:(NSString *)type valueId:(NSString *)vId username:(NSString *)name success:(getShreSuccess)success fail:(ESNetworkFail)fail;


@end
