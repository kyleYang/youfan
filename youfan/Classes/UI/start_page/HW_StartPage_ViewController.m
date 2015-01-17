//
//  HW_StartPage_ViewController.m
//  7orange
//
//  Created by robin on 13-1-25.
//  Copyright (c) 2013年 Wong Hsin. All rights reserved.
//

#import "HW_StartPage_ViewController.h"
#import "ImageHelper.h"


//安装后是否是第一次启动
#define kHaveUsed @"haveused"
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//首页
static int kImageNum = 4;

@interface HW_StartPage_ViewController ()
- (void)createPages;
@end

@implementation HW_StartPage_ViewController
@synthesize myTimer = _myTimer;
@synthesize haveShowOnce = _haveShowOnce;
@synthesize myScrollView = _myScrollView;
@synthesize gotoIndexPageButton = _gotoIndexPageButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.haveShowOnce = NO;
        if(IOS_VERSION>=7.0){
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = YES;
            self.automaticallyAdjustsScrollViewInsets = NO;
        }

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createPages];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
//timer调用函数
-(void)timerFired:(NSTimer *)timer
{
    [timer invalidate];
    
    [self gotoIndexPage:nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (IBAction)gotoIndexPage:(id)sender
{
    
    [UIView animateWithDuration:1.0 animations:^{
        
        self.view.alpha = .8f;
        
    } completion:^(BOOL finished) {
        
        [self.navigationController popViewControllerAnimated:NO];
        
    }];
    
  
}

- (void)createPages
{
    NSInteger windowH = [[UIScreen mainScreen] bounds].size.height;
    NSInteger windowW = [[UIScreen mainScreen] bounds].size.width;
    UIImageView *startView = nil;
    for ( int i = 0, num = kImageNum; i < num; i++)
    {
        //从NIB文件创建视图
        NSString *imageName = [@"index-0" stringByAppendingFormat:@"%d",i+1];
        startView = [[UIImageView alloc]initWithImage:[ImageHelper imageWithName:imageName]];
        
        //添加到switchview
        [startView setFrame:CGRectMake((windowW*i), 0, windowW, windowH)];
        [self.myScrollView addSubview:startView];
    }
    
    //移动button的位置
    CGRect oldframe = self.gotoIndexPageButton.frame;
    CGRect newframe = CGRectOffset(oldframe, windowW*(kImageNum-1) , 0);
    self.gotoIndexPageButton.frame = newframe;
    
    //设置srcollview的范围
    [self.myScrollView setContentSize:CGSizeMake(windowW*kImageNum, windowH-20)];
}

#pragma mark - scrollView && page
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger windowW = [[UIScreen mainScreen] bounds].size.width;
    NSInteger currentPage = scrollView.contentOffset.x/windowW;
    //只有最后一页时，按钮才起作用
    if ((kImageNum -1) == currentPage)
    {
        self.gotoIndexPageButton.enabled = YES;
    }
    else
    {
        self.gotoIndexPageButton.enabled = NO;
    }
}
@end
