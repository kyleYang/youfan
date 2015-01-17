//
//  HWLoginParser.h
//  7orange
//
//  Created by Wong Hsin on 12-9-23.
//  Copyright (c) 2012年 Wong Hsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWXMLBase.h"
//登录接口 （新版：只调一个接口完成登录）
//http://www.7orange.net/csp/page/check_login.jsp?_=1347003154659&ipt_DUserAccount=orange&ipt_DUserPasswd=e01d67a002dfa0f3
//参数：
//ipt_DUserAccount	orange		用户名
//ipt_DUserPasswd	e01d67a002dfa0f3	密码  MD5加密取1-17 的16位
//sourceID=来源编号
//返回：返回成功后，取节点cookieMap下所有子节点放入cookie中（cookie的name、value值对应节点的名称和值）。然后跳转到对应页面。
//<?xml version="1.0" encoding="utf-8"?>
//<r>
//<retcode>0</retcode>		0，成功；-1，不成功
//<retmsg>ok</retmsg>			返回描述信息，如：帐户不存在或者输入密码有误。
//<nickname>淡定</nickname>		昵称
//<type>2<pe>			客户类型：2，散户；1，商旅；5，手机直接预订；
//<source_type>2</source_type>	来源类型：2，新浪微博；1，腾讯微博
//<sourceUID>2653007761</sourceUID>	新浪微博的用户ID
//<qtynum>2 <ynum>
//<user>orange</user>			用户名
//<sinaNickname> </sinaNickname>	新浪微博昵称
//<u><user_no>60982</user_no><user>orange</user><pwd>e01d67a002dfa0f3</pwd><email>temp@12345.com</email><mobile></mobile><logtime>2013-02-28 14:10:19</logtime><name>胡宏兵</name><birthday></birthday><sex><x><addr></addr><zip_code></zip_code><id></id><idtype></idtype><valid><alid><type>1<pe><username></username><suggester></suggester><suggest_type></suggest_type><give_status></give_status><policy_id></policy_id><remarks></remarks><createdate>2012-12-21 16:17:50</createdate><source_type></source_type><remindflag>1</remindflag><nickname></nickname><present_status></present_status><presentFlag></presentFlag><Giveflag>1</Giveflag><Invit_cardNo></Invit_cardNo><invitCls></invitCls><grade_level></grade_level><grade_levelname>会员</grade_levelname><logip>192.168.1.193</logip><next_bidtime></next_bidtime><company_id></company_id><cashFlag>1</cashFlag><sourceUID></sourceUID><sourceURL></sourceURL><creteip></creteip><sinaNickname></sinaNickname><tencentUID></tencentUID><tencentNickname></tencentNickname><send_type>1<nd_type><sinaImageUrl></sinaImageUrl><trip_comid>1</trip_comid><trip_deptid>220</trip_deptid><trip_custtype>C</trip_custtype><trip_role>SYS</trip_role><trip_job_number></trip_job_number></u>
//<cookieMap>
//<sourceUID></sourceUID>
//<logtime>2013-04-07 14:48:37</logtime>
//<nr>40</nr>
//<nickname>%E6%B7%A1%E5%AE%9A</nickname>
//<source_type></source_type>
//<user_no>60982</user_no>
//<_qty_num>1</_qty_num>
//<sessionid>0104545137597B3AB000BBF0370BC79A<ssionid>
//<type>1<pe>
//<orid>8c6575088db48d754589b0a0b8aa8d17</orid>
//<tripName>%E8%83%A1%E5%AE%8F%E5%85%B5</tripName>
//<nd>5</nd>
//<comName>%E6%B7%B1%E5%9C%B3%E5%B8%82%E5%A5%87%E7%A8%8B%E7%BD%91%E6%97%85%E8%A1%8C%E7%A4%BE%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8</comName>
//<role>YG</role>
//<sessionid1>C22222C3E17A0A6F43A86D3FEB29E166<ssionid1>
//<nh>9</nh>
//<user>orange</user>
//<mobile></mobile>
//<custType>C</custType>
//</cookieMap>
//</r>

@interface HWLoginParser : HWXMLBase
@property (nonatomic, retain) NSString *currentContent;
@property (nonatomic, retain) NSMutableDictionary *loginResult;
@property (nonatomic, retain) NSMutableDictionary *userInfo;
@property (nonatomic, retain) NSMutableDictionary *cookieMap;
@end
