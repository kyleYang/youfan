//
//  cantingListViewController.m
//  youfan
//
//  Created by 123 on 15-1-14.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "cantingListViewController.h"
#import "Env.h"
#import "SONetwork.h"
#import "SVProgressHelp.h"
#import "canListTableViewCell.h"
#import "HotRepast.h"
#import "Util.h"
#import "HotProduct.h"
#import "HotActivity.h"
#import "SOCityViewController.h"
#import "UIHelper.h"
#import "SOCodeReaderViewController.h"
#import "SOBaseWebViewController.h"
#import "ListHeadView.h"
#import "SOLoginManager.h"

#define kHeadHeight 60
#define kUserName @"usr"
#define kPassword @"pwd"


@interface cantingListViewController ()<ListHeadViewDelegate>
@property (nonatomic, strong)  ListHeadView *headView;
@property (nonatomic, strong) SONetwork *request;

@end

@implementation cantingListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"列表";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.headView];
    
    if ([Env shareEnv].systemMajorVersion >=7) {
        self.automaticallyAdjustsScrollViewInsets = FALSE;
        self.tableView.contentInset = UIEdgeInsetsZero;
        

    }
    
    
    CGFloat headHeight =  [Env shareEnv].screenWidth * kHeadHeight/kStandardWidth;
    NSDictionary *views = NSDictionaryOfVariableBindings(_headView);
    NSDictionary *metrics = @{@"marginTop":@20,@"headHeight":@(headHeight)};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_headView]|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_headView(headHeight)]" options:0 metrics:metrics views:views]];
    
    CGRect frame = self.tableView.frame;
    frame.origin.y = headHeight;
    frame.size.height = CGRectGetHeight(self.view.frame) - headHeight;
    self.tableView.frame = frame;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.navigationController.navigationBarHidden = TRUE;
    
    [self contentRefresh];
  
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //
    //    [SOLocationManager shareInstance].delegate = self;
    //    if ([SOLocationManager shareInstance].threeCodeSaved == nil) { //没有三字码、城市名字
    //
    //    }else{
    //
    //        if (![[SOLocationManager shareInstance].threeCodeSaved isEqualToString:[SOLocationManager shareInstance].threeCodeTemp] || [self.dataArray count] == 0) { //重新选择了城市
    //
    //            [SOLocationManager shareInstance].threeCodeTemp = [SOLocationManager shareInstance].threeCodeSaved;
    //            [self.headView.cityLabel setTitle:[SOLocationManager shareInstance].citySaved forState:UIControlStateNormal];
    //            [self contentRefresh];
    //
    //        }
    //    }
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (ListHeadView *)headView
{
    if (_headView != nil) {
        return _headView;
    }
    
    _headView = [[ListHeadView alloc] initAutoLayout];
    _headView.delegate =self;
    return _headView;
    
}


- (SONetwork *)request
{
    if (_request != nil) {
        return _request;
    }
    
    _request = [[SONetwork alloc] init];
    return _request;
}

- (void)contentRefresh
{
    [SVProgressHelp showHUD];
    __weak typeof(self) weakSelf = self;
    
    [self.request ListRefreshwithCode:@"SZX" withkeyWord:@"" withStartIndex:@"0" withPageSize:@"50" withLat:@"" withLng:@"" Success:^(NSArray *array) {
        [SVProgressHelp dismissHUD];
        [weakSelf.dataArray removeAllObjects];
        
        [weakSelf.dataArray addObjectsFromArray:array];
        
        [weakSelf.tableView reloadData];
        
        if ([Env shareEnv].systemMajorVersion >=7) {
            weakSelf.automaticallyAdjustsScrollViewInsets = FALSE;
            weakSelf.tableView.contentInset = UIEdgeInsetsZero;
        }

    } fail:^(NSString *error) {
          [SVProgressHelp dismissHUDError:error];
    }];
        
        
       
    }




- (void)ListHeadViewCitySelete:(ListHeadView *)view
{
    
    SOCityViewController *cityController = [[SOCityViewController alloc] initWithNibName:nil bundle:nil];
    [UIHelper tabController:self pushSubController:cityController];
}

- (void)ListHeadViewScanning:(ListHeadView *)view
{
    SOCodeReaderViewController *scanViweController = [[SOCodeReaderViewController alloc] initWithCancelButtonTitle:@"取消"];
    [UIHelper tabController:self pushSubController:scanViweController];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HotRepast *ht;
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString* username=[accountDefaults objectForKey:kUserName];
    
    
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[HotRepast class]]) {
        ht= (HotRepast *)object;

    }
    SOBaseWebViewController *webController = [[SOBaseWebViewController alloc] init];

    NSString* str=[NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"http://m.7orange.net/canyinapp/zhaopaicai.html?os=ios",@"&did=",ht.clientCode,@"&shopId=",ht.shopId,@"&memberNo=",username];
    
    webController.loadingURLString=str;

    [UIHelper viewController:self pushSubController:webController];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}
-(UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    canListTableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[canListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[HotRepast class]]) {
        HotRepast *hotShop = (HotRepast *)object;
        if (hotShop.shopPic != nil) {
            
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:hotShop.shopPic] placeholderImage:nil];
            
        }
      
        cell.iconImageView.image = [UIImage imageNamed:@"type_shop"];
        cell.priseIconView.image=[UIImage imageNamed:@"repast_good"];
        cell.singIconView.image=[UIImage imageNamed:@"reapst_eye"];
        cell.shopNameLabel.text=hotShop.shopName;
        NSString* str1,*str2,*str3,*str4;
        str2=@" | ";
        str3=hotShop.shopType;
        str1=hotShop.address;
        str4=hotShop.avgPrice;
        NSString* pro=[NSString stringWithFormat:@"%@ %@ %@ %@ %@",str1,str2,str3,
                       @"  ", str4 ];
        cell.shopAddressLabel.text =pro;
        cell.scroeLabel.text=hotShop.score;
        cell.singNameLabel.text=hotShop.Sign_number;
        cell.priseNameLabel.text=hotShop.Prise_number;
        cell.distanceLabel.text=hotShop.distance;

    }
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 
#pragma mark-back
-(void)backtoMain:(ListHeadView *)view{
   
    [self.navigationController popViewControllerAnimated:YES];
    

}
@end
