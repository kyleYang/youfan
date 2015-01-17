//
//  SOBaseWebViewController.m
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOBaseWebViewController.h"
#import "NoticeHelp.h"
#import "SVProgressHelp.h"
#import "WXApi.h"
#import "SDWebImageManager.h"
#import "UIImage+EXC.h"

@interface SOBaseWebViewController ()<UIActionSheetDelegate>


@property (nonatomic, strong) SONetwork *request;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) ShareModel *shareModel;

@property (nonatomic, strong) UIBarButtonItem *closeButtonItem;
@property (nonatomic, strong) UIBarButtonItem *gobackButtonItem;

@end

@implementation SOBaseWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.loadingURLString != nil) {
        [self loadURL:[NSURL URLWithString:self.loadingURLString]];
    }
    
}

- (UIBarButtonItem *)closeButtonItem
{
    if (_closeButtonItem != nil) {
        return _closeButtonItem;
    }
    
    
    _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"button.close", @"commonlib", nil) style:UIBarButtonItemStylePlain target:self action:@selector(closeAction:)];
    return _closeButtonItem;
}


- (UIBarButtonItem *)gobackButtonItem
{
    if (_gobackButtonItem != nil) {
        return _gobackButtonItem;
    }
    
    _gobackButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"button.close", @"commonlib", nil) style:UIBarButtonItemStylePlain target:self action:@selector(closeAction:)];
    return _gobackButtonItem;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.delegate = self;

    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setToolbarHidden:YES animated:NO];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if (self.loadingURLString != nil) {
        
        
        
        return;
    }
    
    
    if (!_loaded || [SOLoginManager shareInstance].hasLogin != _cacheLogin) {
        
        
        NSURL *loadURL = [self loadCacheURL];
        
        NSLog(@"[self loadCacheURL] :%@ ",loadURL);
        
        [self loadURL:loadURL];
        _loaded = TRUE;
        _cacheLogin = [SOLoginManager shareInstance].hasLogin;
        
    }
    
    
}


- (SONetwork *)request
{
    if (_request != nil) {
        return _request;
    }
    
    _request = [[SONetwork alloc] init];
    return _request;
}

- (void)reloadCurrentURL
{
    NSURL *loadURL = [self loadCacheURL];
    [self loadURL:loadURL];
}

- (NSURL *)loadCacheURL
{
    return [NSURL URLWithString:@""];
}


- (void)updateNavigationItem
{
    if ([self.wkWebView canGoBack]) {
        self.navigationItem.leftBarButtonItems = @[self.gobackButtonItem,self.closeButtonItem];
    }else{
        self.navigationItem.leftBarButtonItem = self.gobackButtonItem;
    }
}


- (void)gobackAction:(id)sender
{
    if ([self.wkWebView canGoBack]) { //能够回退
        
        [self.wkWebView goBack];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)closeAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    
    
    NSLog(@"webBrowser:%@, decidePolicyForNavigationAction:%@, decisionHandler:%@",webView,navigationAction,decisionHandler);
    
    
    NSLog(@"navigationAction :%@ .request.URL absoluteString: %@",navigationAction,[navigationAction.request.URL absoluteString]);
    
    if ([[navigationAction.request.URL absoluteString] containsString:@"youfanloginforios"]) { //ios8 method
        
        [self youfanLogin];
        
        decisionHandler(WKNavigationActionPolicyCancel);
        
    }else if ([[navigationAction.request.URL scheme] isEqual:@"calllogout"]) { //ios8 method
        
        [self logout:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
        
    }else if([[navigationAction.request.URL scheme] isEqual:@"callgoback"]){
        
        [self.navigationController popViewControllerAnimated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
        
        
    }else if([[navigationAction.request.URL scheme] isEqualToString:@"sharewx"]) {
        
        [self paraUrlQuery:navigationAction.request.URL.query];
       
        decisionHandler(WKNavigationActionPolicyCancel);
        
    }else{
        //            UIApplication *application = [UIApplication sharedApplication];
        //            [application openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyAllow);
        
    }
    
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@"webView:%@, shouldStartLoadWithRequest:%@",webView,request);
    
    BOOL  value = [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    
    if ([[request.URL absoluteString] rangeOfString:@"youfanloginforios"].location!=NSNotFound) { //ios8 method
        
        [self youfanLogin];
        
        return FALSE;
        
    }else if ([[request.URL scheme] isEqual:@"calllogout"]) { //ios7
        
        [self logout:nil];
        
        
        return FALSE;
        
    }else if([[request.URL scheme] isEqual:@"callgoback"]){
        
        [self.navigationController popViewControllerAnimated:YES];
        return FALSE;
        
        
    }else if([[request.URL scheme] isEqualToString:@"sharewx"]) {
        
        [self paraUrlQuery:request.URL.query];
        
        return FALSE;
        
    }else{
        //            UIApplication *application = [UIApplication sharedApplication];
        //            [application openURL:request.URL];
        
        return TRUE;
    }
    
    
    return value;
}



- (void)webBrowser:(KINWebBrowserViewController *)webBrowser didFinishLoadingURL:(NSURL *)URL
{
    [self updateNavigationItem];
}

- (void)paraUrlQuery:(NSString *)query
{

    
    NSString *type = nil;
    NSString *typeId = nil;
    
    if (query != nil) {
        
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        
        for (NSString *pair in pairs) {
            
            NSArray *keyValues = [pair componentsSeparatedByString:@"="];
            if (keyValues.count == 2) {
                
                if ([keyValues[0] isEqualToString:@"type"]) {
                    type = keyValues[1];
                }else if([keyValues[0] isEqualToString:@"id"]){
                    typeId = keyValues[1];
                }
                
            }
            
        }
        
    }
    
    
    self.type = type;
    self.value = typeId;
    
    if (type == nil || typeId == nil) { //获取值失败
        
        
        [SVProgressHelp dismissHUDError:@"微信分享失败"];
        
        return;
        
        
        
        
        
    }
    
    
    if(![WXApi isWXAppInstalled])
    {
        [NoticeHelp showSureAlertInViewController:self message:@"您还没有安装微信"];
        
        return;
    }
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"好友",@"朋友圈", nil];
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        
        [self shareToWeixinSence:WXSceneSession];
        
        
    }else if(buttonIndex == 1){
        [self shareToWeixinSence:WXSceneTimeline];
    }
    
}



- (void)shareToWeixinSence:(int)scence
{
    
    [SVProgressHelp showHUD];
    
    [self.request wxShareMessageType:self.type valueId:self.value username:[[SOLoginManager shareInstance] getLoginUserName] success:^(ShareModel *model) {
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.image] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            [SVProgressHelp dismissHUD];
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = model.title;
            message.description = model.des;
            [message setThumbImage:[image imageByScalingAndCroppingForSize:CGSizeMake(200, 200)]];
            
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = model.url;
            
            message.mediaObject = ext;
            message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = scence;
            [WXApi sendReq:req];

            
        }];
        
        
        
        
        
    } fail:^(NSString *error) {
        
        [SVProgressHelp dismissHUDError:error];
        
    }];
    
}






- (void)logout:(id)sender
{
    [NoticeHelp showChoiceAlertInViewController:self message:@"是否退出登录" tapBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            [SOLoginManager shareInstance].loginStatus = nil; //退出登录
            [SOLoginManager shareInstance].wxUserInfo = nil;
            
            [self.navigationController.rdv_tabBarController setSelectedIndex:2];
        }
    }];
}

- (void)youfanLogin
{
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

@end
