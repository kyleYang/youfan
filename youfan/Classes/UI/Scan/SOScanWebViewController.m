//
//  SOScanWebViewController.m
//  youfan
//
//  Created by Kyle on 15/1/5.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "SOScanWebViewController.h"


#define kzhapaicaiUrl @"http://www.7orange.net/canyinapp/zhaopaicai.html?os=ios"
#define kdid @"&did="
#define kshopId @"&shopId="
#define kmemberNo @"&memberNo="
#define kUserName @"usr"


@interface SOScanWebViewController()

@property (nonatomic, copy) NSString *urlString;

@end

@implementation SOScanWebViewController



- (instancetype)initWithScanString:(NSString *)string
{
    if (self = [super initWithConfiguration:nil]) {
       
        NSRange rg=[string rangeOfString:@"clientCode"];
        
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString* username=[accountDefaults objectForKey:kUserName];
        
        if(username==nil){
            username=@"";
        }
        
        if(rg.length!=0){
            //招牌菜
            NSArray *arry=[string componentsSeparatedByString:@"?"];
            
            NSArray *art=[self mSplit:arry];
            
            if(art!=nil){
                string=[NSString stringWithFormat:@"%@%@%@%@%@%@%@",kzhapaicaiUrl,kshopId,[[[art objectAtIndex:0]componentsSeparatedByString:@"="]objectAtIndex:1],kdid,[[[art objectAtIndex:1]componentsSeparatedByString:@"="]objectAtIndex:1],kmemberNo,username];
            }
       
            
        }
        NSLog(@"urlString-----%@",string);
        self.urlString = string;
    }
    
    return self;
    
}

- (NSURL *)loadCacheURL
{
    if (self.urlString != nil) {
        return [NSURL URLWithString:self.urlString];
    }
    
    return [NSURL URLWithString:@""];
}
#pragma mark
#pragma mark－ string split

-(NSArray*) mSplit:(NSArray*)array{
    NSLog(@"arrycount is ----%i",array.count);
    if(array.count==2){
        
        NSArray* ay=[[array objectAtIndex:1]componentsSeparatedByString:@"&"];
        if(ay.count==2){
            return ay;
        }else {
            return nil;
        }
    }
    
    else{
        return nil;
    }
}


@end


