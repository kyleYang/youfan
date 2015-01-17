//
//  NSString+Util.m
//  youfan
//
//  Created by Kyle on 15/1/2.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "NSString+Util.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString(Util)

+ (NSString *)convertKeyAndValueFrom:(NSDictionary*)parameters
{
    NSString *ret = @"";
    
    //得到词典中所有KEY值，并按字母表排序
    NSArray * enumeratorKey = [[parameters allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in enumeratorKey)
    {
        NSString *value = [parameters objectForKey:key];
        if (nil != value)
        {
            ret = [ret stringByAppendingFormat:@"%@=%@&",key, value];
        }
    }
    
    return ret;
}

+ (BOOL)isEmpty:(NSString*)str
{
    if((str != nil) && ([str length] > 0))
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

- (BOOL)isEqualTo:(NSString *)element
{
    return NSOrderedSame == [self compare:element options:NSCaseInsensitiveSearch];
}

- (BOOL) contains:(NSString*)str
{
    NSRange rg = [self rangeOfString:str];
    if(rg.location == NSNotFound)
    {
        return  FALSE;
    }
    else
    {
        return TRUE;
    }
}

- (NSString*)md5Convert
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    NSString *md5 = [NSString stringWithFormat:
                     @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                     result[0], result[1], result[2], result[3], result[4],
                     result[5], result[6], result[7], result[8], result[9],
                     result[10], result[11], result[12], result[13], result[14],result[15]];
    return md5;
}

- (NSString*)md5From:(NSUInteger)location atLen:(NSUInteger)len
{
    NSString *md5 = [self md5Convert];
    return [md5 substringWithRange:NSMakeRange(location, len)];
}

- (NSString *)URLEncodedString
{
    NSString *result = ( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                              kCFAllocatorDefault,
                                                                                              (CFStringRef)self,
                                                                                              CFSTR("/{},[]"),
                                                                                              CFSTR("!*();@+$%#"),
                                                                                              kCFStringEncodingUTF8));
    
    return result;
}

- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                                                             kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}

- (NSString *)converForJsonOfIos
{
    NSString *ret = @"";
    
    ret = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    ret = [ret stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    ret = [ret stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return ret;
}

- (NSString *)GBKEncode
{
    //***kCFStringEncodingGB_18030_2000（GBK）
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding
    (kCFStringEncodingGB_18030_2000);
    //***转码
    NSString *afterEnc=[self stringByAddingPercentEscapesUsingEncoding:enc];
    
    return afterEnc;
}

- (NSString *)GBKDecode
{
    //***kCFStringEncodingGB_18030_2000（GBK）
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //***转码
    NSString *afterDec=[self stringByReplacingPercentEscapesUsingEncoding:enc];
    
    return afterDec;
}

@end
