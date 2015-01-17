//
//  HWResetPasswordParser.m
//  7orange
//
//  Created by robin on 13-2-19.
//  Copyright (c) 2013年 Wong Hsin. All rights reserved.
//

#import "HWResetPasswordParser.h"

@implementation HWResetPasswordParser
@synthesize currentContent = _currentContent;
@synthesize retcode = _retcode;
@synthesize retmsg = _retmsg;

- (id)init
{
    if (self = [super init])
    {
        self.currentContent = nil;
        self.retcode = FALSE;
        self.retmsg = nil;
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"root"])
    {
        self.currentContent = @"";
        self.retcode = FALSE;
        self.retmsg = nil;
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
