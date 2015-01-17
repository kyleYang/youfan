//
//  HWLoginParser.m
//  7orange
//
//  Created by Wong Hsin on 12-9-23.
//  Copyright (c) 2012年 Wong Hsin. All rights reserved.
//

#import "HWLoginParser.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HWLoginParser

@synthesize currentContent = _currentContent;
@synthesize loginResult = _loginResult;
@synthesize userInfo = _userInfo;
@synthesize cookieMap = _cookieMap;

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

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([@"r" isEqualToString:elementName])
    {
        self.loginResult = [[NSMutableDictionary alloc] init];
    }

    if ([@"u" isEqualToString:elementName])
    {
        self.userInfo = [[NSMutableDictionary alloc] init];
    }
    
    if ([@"cookieMap" isEqualToString:elementName])
    {
        self.cookieMap = [[NSMutableDictionary alloc] init];
    }
    
    self.currentContent = @"";
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([@"u" isEqualToString:elementName])
    {
        [self.loginResult setObject:self.userInfo forKey:@"u"];
    }
    else if ([@"cookieMap" isEqualToString:elementName])
    {
        [self.loginResult setObject:self.cookieMap forKey:@"cookieMap"];
    }
    else if ([@"retcode" isEqualToString:elementName])
    {
        self.retcode = ![self.currentContent boolValue];
        
        [self.loginResult setObject:self.currentContent forKey:@"retcode"];
    }
    else if ([@"retmsg" isEqualToString:elementName])
    {
        
        self.retmsg = self.currentContent;
        
        [self.loginResult setObject:self.currentContent forKey:@"retmsg"];
    }
    else if ([@"qtynum" isEqualToString:elementName])
    {
        [self.loginResult setObject:self.currentContent forKey:@"qtynum"];
    }
    else if ([@"type" isEqualToString:elementName])
    {
        if ((nil == self.userInfo) && (nil == self.cookieMap))
        {
            //r 下面的元素
            [self.loginResult setObject:self.currentContent forKey:@"type"];
        }
    }
    else if ([@"nickname" isEqualToString:elementName])
    {
        if ((nil == self.userInfo) && (nil == self.cookieMap))
        {
            //r 下面的元素
            [self.loginResult setObject:self.currentContent forKey:@"nickname"];
        }
    }
    else if ([@"source_type" isEqualToString:elementName])
    {
        if ((nil == self.userInfo) && (nil == self.cookieMap))
        {
            //r 下面的元素
            [self.loginResult setObject:self.currentContent forKey:@"source_type"];
        }
    }
    else if ([@"sourceUID" isEqualToString:elementName])
    {
        if ((nil == self.userInfo) && (nil == self.cookieMap))
        {
            //r 下面的元素
            [self.loginResult setObject:self.currentContent forKey:@"sourceUID"];
        }
    }
    else if ([@"user" isEqualToString:elementName])
    {
        if ((nil == self.userInfo) && (nil == self.cookieMap))
        {
            //r 下面的元素
            [self.loginResult setObject:self.currentContent forKey:@"user"];
        }
    }
    else if ([@"sinaNickname" isEqualToString:elementName])
    {
        if (nil == self.userInfo)
        {
            //r 下面的元素
            [self.loginResult setObject:self.currentContent forKey:@"sinaNickname"];
        }
    }

    
    //u下面的元素
    if ([@"nickname" isEqualToString:elementName])
    {
        if (nil == self.cookieMap)
        {
            //u 下面的元素
            [self.userInfo setObject:self.currentContent forKey:@"nickname"];
        }
    }
    else if ([@"user" isEqualToString:elementName])
    {
        if (nil == self.cookieMap)
        {
            [self.userInfo setObject:self.currentContent forKey:@"user"];
        }
    }
    else if ([@"logtime" isEqualToString:elementName])
    {
        if (nil == self.cookieMap)
        {
            //u下面的元素
            [self.userInfo setObject:self.currentContent forKey:@"logtime"];
        }
    }
    else if ([@"mobile" isEqualToString:elementName])
    {
        if (nil == self.cookieMap)
        {
            [self.userInfo setObject:self.currentContent forKey:@"mobile"];
        }
    }
    else if ([@"type" isEqualToString:elementName])
    {
        if (nil == self.cookieMap)
        {
            [self.userInfo setObject:self.currentContent forKey:@"type"];
        }
    }
    else if ([@"user_no" isEqualToString:elementName])
    {
        if (nil == self.cookieMap)
        {
            [self.userInfo setObject:self.currentContent forKey:@"user_no"];
        }
    }
    else if ([@"sourceUID" isEqualToString:elementName])
    {
        if (nil == self.cookieMap)
        {
            //u 下面的元素
            [self.userInfo setObject:self.currentContent forKey:@"sourceUID"];
        }
    }
    else if ([@"source_type" isEqualToString:elementName])
    {
        if (nil == self.cookieMap)
        {
            //u 下面的元素
            [self.userInfo setObject:self.currentContent forKey:@"source_type"];
        }
    }
    else if ([@"sinaNickname" isEqualToString:elementName])
    {
        if (self.userInfo)
        {
            //u 下面的元素
            [self.userInfo setObject:self.currentContent forKey:@"sinaNickname"];
        }
    }
    else if ([@"trip_job_number" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"trip_job_number"];
    }
    else if ([@"trip_role" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"trip_role"];
    }
    else if ([@"trip_custtype" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"trip_custtype"];
    }
    else if ([@"trip_deptid" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"trip_deptid"];
    }
    else if ([@"trip_comid" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"trip_comid"];
    }
    else if ([@"sinaImageUrl" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"sinaImageUrl"];
    }
    else if ([@"tencentNickname" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"tencentNickname"];
    }
    else if ([@"tencentUID" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"tencentUID"];
    }
    else if ([@"creteip" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"creteip"];
    }
    else if ([@"sourceURL" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"sourceURL"];
    }
    else if ([@"cashFlag" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"cashFlag"];
    }
    else if ([@"company_id" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"company_id"];
    }
    else if ([@"next_bidtime" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"next_bidtime"];
    }
    else if ([@"logip" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"logip"];
    }
    else if ([@"grade_levelname" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"grade_levelname"];
    }
    else if ([@"grade_level" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"grade_level"];
    }
    else if ([@"invitCls" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"invitCls"];
    }
    else if ([@"Invit_cardNo" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"Invit_cardNo"];
    }
    else if ([@"Giveflag" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"Giveflag"];
    }
    else if ([@"presentFlag" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"presentFlag"];
    }
    else if ([@"present_status" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"present_status"];
    }
    else if ([@"remindflag" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"remindflag"];
    }
    else if ([@"createdate" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"createdate"];
    }
    else if ([@"remarks" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"remarks"];
    }
    else if ([@"policy_id" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"policy_id"];
    }
    else if ([@"give_status" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"give_status"];
    }
    else if ([@"suggest_type" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"suggest_type"];
    }
    else if ([@"suggester" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"suggester"];
    }
    else if ([@"username" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"username"];
    }
    else if ([@"valid" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"valid"];
    }
    else if ([@"idtype" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"idtype"];
    }
    else if ([@"id" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"id"];
    }
    else if ([@"zip_code" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"zip_code"];
    }
    else if ([@"addr" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"addr"];
    }
    else if ([@"sex" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"sex"];
    }
    else if ([@"birthday" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"birthday"];
    }
    else if ([@"name" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"name"];
    }
    else if ([@"email" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"email"];
    }
    else if ([@"pwd" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"pwd"];
    }
    else if ([@"send_type" isEqualToString:elementName])
    {
        [self.userInfo setObject:self.currentContent forKey:@"send_type"];
    }
    
    //cookieMap
    if ([@"sourceUID" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"sourceUID"];
    }
    else if ([@"custType" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"custType"];
    }
    else if ([@"mobile" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"mobile"];
    }
    else if ([@"user" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"user"];
    }
    else if ([@"nh" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"nh"];
    }
    else if ([@"sessionid1" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"sessionid1"];
    }
    else if ([@"role" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"role"];
    }
    else if ([@"comName" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"comName"];
    }
    else if ([@"deptName" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"deptName"];
    }
    else if ([@"comid" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"comid"];
    }
    else if ([@"deptid" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"deptid"];
    }
    else if ([@"comCode" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"comCode"];
    }
    else if ([@"nd" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"nd"];
    }
    else if ([@"nr" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"nr"];
    }
    else if ([@"tripName" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"tripName"];
    }
    else if ([@"orid" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"orid"];
    }
    else if ([@"type" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"type"];
    }
    else if ([@"sessionid" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"sessionid"];
    }
    else if ([@"_qty_num" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"_qty_num"];
    }
    else if ([@"user_no" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"user_no"];
    }
    else if ([@"source_type" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"source_type"];
    }
    else if ([@"nr" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"nr"];
    }
    else if ([@"nickname" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"nickname"];
    }
    else if ([@"logtime" isEqualToString:elementName])
    {
        [self.cookieMap setObject:self.currentContent forKey:@"logtime"];
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.loginResult = nil;
    self.userInfo = nil;
    self.cookieMap = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.currentContent = [self.currentContent stringByAppendingString:string];
}
@end
