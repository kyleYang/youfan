//
//  HWVerifyCodeParser.m
//  7orange
//
//  Created by robin on 12-12-14.
//  Copyright (c) 2012年 Wong Hsin. All rights reserved.
//

#import "HWVerifyCodeParser.h"

@implementation HWVerifyCodeParser

@synthesize currentContent = _currentContent;


- (id)init
{
    if (self = [super init])
    {
        self.currentContent = nil;
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"r"])
    {
        self.currentContent = @"";
        return;
    }

    self.currentContent = @"";
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"retcode"])
    {
        self.retcode = ![self.currentContent boolValue];
    }
    else if ([elementName isEqualToString:@"retmsg"])
    {
        self.retmsg = self.currentContent;
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.currentContent = [self.currentContent stringByAppendingString:string];
}

@end
