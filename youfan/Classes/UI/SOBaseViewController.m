//
//  SOBaseViewController.m
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOBaseViewController.h"
#import "SVProgressHUD.h"
#import "Env.h"

@interface SOBaseViewController ()<ErrorViewDelegate>

@property (nonatomic, strong, readwrite) ESErrorView *errorView;

@end

@implementation SOBaseViewController

- (void)dealloc
{
    NSLog(@"dealloc %@",self);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([Env shareEnv].systemMajorVersion >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (ESErrorView *)errorView
{
    if (_errorView != nil) {
        
        return _errorView;
    }
    
    _errorView = [[ESErrorView alloc] initWithFrame:self.view.bounds];
    _errorView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _errorView.delegate = self;
    [self.view addSubview:_errorView];
    
    return _errorView;
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillAppearNotification:)
                                                 name:SVProgressHUDWillAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDidApperaNotification:)
                                                 name:SVProgressHUDDidAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillDisappearNotification:)
                                                 name:SVProgressHUDWillDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDidDisappearNotification:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDWillAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDDidAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDWillDisappearNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDDidDisappearNotification object:nil];
    [super viewWillDisappear:animated];
    
}


#pragma mark ---------
#pragma makr instance

- (void)contentRefresh
{
    
}


- (void)userExpired
{
    
}


- (void)errorActionHelp
{
    
}

- (void)contentLoadMore
{
    
}



#pragma mark ------
#pragma mark SVProgressHUD Noticication
- (void)handleWillAppearNotification:(NSNotification *)notif
{
    
}

- (void)handleDidApperaNotification:(NSNotification *)notif
{
    
}

- (void)handleWillDisappearNotification:(NSNotification *)notif
{
    
}

- (void)handleDidDisappearNotification:(NSNotification *)notif
{
    
}



- (void)networkErrorNotice
{
    
    self.errorView.errorType = NetworkError;
    [self showNoticeImage:[UIImage imageNamed:@"error_network_fail"] text:NSLocalizedString(@"error.notice.network.fail", nil) buttonTitle:NSLocalizedStringFromTable(@"button.refresh", @"commonlib", nil)];

}

- (void)showNoticeImage:(UIImage *)image text:(NSString *)text buttonTitle:(NSString *)title
{
    
    [self.view addSubview:self.errorView];
    
    self.errorView.errorImage.image = image;
    self.errorView.noticeLabel.text = text;
    
    if (title.length != 0) {
        
        [self.errorView.actionButton setTitle:title forState:UIControlStateNormal];
        self.errorView.actionButton.hidden = FALSE;
        
    }else{
        self.errorView.actionButton.hidden = TRUE;
    }
    
}


- (void)ESErrorViewTouch:(ESErrorView *)view errorType:(ErrorType)errorType
{
    NSLog(@"ESErrorViewTouch:%@ errorType:%ld",view,errorType);
    
    [self.errorView removeFromSuperview];
    if (errorType == ShopEmpty) { //商品为空，跳到首页
        [self errorActionHelp];
    }else{
        [self contentRefresh];
    }
    
    
    
}






@end
