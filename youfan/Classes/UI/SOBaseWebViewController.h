//
//  SOBaseWebViewController.h
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "KINWebBrowserViewController.h"
#import "SOLoginManager.h"
#import "SONetwork.h"



@interface SOBaseWebViewController : KINWebBrowserViewController<KINWebBrowserDelegate>
{
    BOOL _loaded;
    BOOL _cacheLogin;
}


@property (nonatomic, strong, readonly) UIBarButtonItem *closeButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *gobackButtonItem;

@property (nonatomic, strong) NSString *loadingURLString;
- (void)updateNavigationItem;
- (NSURL *)loadCacheURL;
- (void)reloadCurrentURL;

- (void)logout:(id)sender;
- (void)youfanLogin;

@end
