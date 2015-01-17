//
//  API.h
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#ifndef youfan_API_h
#define youfan_API_h


#define kWXAPPID @"wx08a194f5e9bf8e84"
#define kWXAppSecret @"c45a9ddc6a21eb9d093763caeb0e90f2"


#define kCookieDomainForLogin @"www.7orange.net"

#define kWeChatHost @"https://api.weixin.qq.com"

#ifdef DEBUG

#define KWebHostSite @"http://www.7orange.net"
#define KAPPHostSite @"http://m.7orange.net"

#else

#define KWebHostSite @"http://www.7orange.net"
#define KAPPHostSite @"http://m.7orange.net"



#endif


#define kHomePageURL @"/hs/service/ShopService"
#define LOGIN_URL @"csp/page/check_login.jsp"
#define LOGOUT_URL @"csp/alipy.do"
#define VERYFY_CODE_URL @"csp/page/member/reset_mobile.jsp"
#define REGISTER_USER_URL @"csp/alipy.do"
#define RESET_PWD_URL @"csp/alipy.do"


#define FRIEND_URL_FORMAT @"%@/canyinapp/haoyouquan.shouye.html?os=ios&did=%@&shopId=%@&memberNo=%@"
#define DINNER_URL_FORMAT @"%@/canyinapp/yuefanju.shouye.html?os=ios&did=%@&shopId=%@&memberNo=%@"
#define ACCOUNT_URL_FORMAT @"%@/canyinapp/jizhangmingxi.html?os=ios&did=%@&shopId=%@&memberNo=%@"
#define USERCENTER_URL_FORMAT @"%@/mall/pc/index.html?os=ios&memberNo=%@"




#define kWebWXShareMessageULR @"/hs/service/ShopService"


#define kWeChatAccessTokenURL @"/sns/oauth2/access_token"
#define kWeChatUserInfoURL @"/sns/userinfo"
#define kWXUnionLoginURL @"/ss/service/user/LoginAndRegisterService"

#endif
