//
//  SOHomeViewController.m
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOHomeViewController.h"
#import "SOLocationManager.h"
#import "SOHomeHeadView.h"
#import "Env.h"
#import "SONetwork.h"
#import "SVProgressHelp.h"
#import "HomeTableCell.h"
#import "HotShop.h"
#import "Util.h"
#import "HotProduct.h"
#import "HotActivity.h"
#import "SOCityViewController.h"
#import "UIHelper.h"
#import "SOCodeReaderViewController.h"
#import "cantingListViewController.h"

#define kHeadHeight 90

@interface SOHomeViewController ()<HomeHeadViewDelegate,locationManageDlegate>

@property (nonatomic, strong) SOHomeHeadView *headView;
@property (nonatomic, strong) SONetwork *request;

@end

@implementation SOHomeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"餐厅/商家";
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
    
    self.tableView.allowsSelection = TRUE;
    
    
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
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SOLocationManager shareInstance].delegate = self;
    if ([SOLocationManager shareInstance].threeCodeSaved == nil) { //没有三字码、城市名字
        
    }else{
        
        if (![[SOLocationManager shareInstance].threeCodeSaved isEqualToString:[SOLocationManager shareInstance].threeCodeTemp] || [self.dataArray count] == 0) { //重新选择了城市
            
            [SOLocationManager shareInstance].threeCodeTemp = [SOLocationManager shareInstance].threeCodeSaved;
            [self.headView.cityLabel setTitle:[SOLocationManager shareInstance].citySaved forState:UIControlStateNormal];
            [self contentRefresh];
           
        }
    }
    
    
    
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


#pragma mark porperty

- (SOHomeHeadView *)headView
{
    if (_headView != nil) {
        return _headView;
    }
    
    _headView = [[SOHomeHeadView alloc] initAutoLayout];
    _headView.delegate = self;
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
    
    [self.request homeRefreshThreeCode:[SOLocationManager shareInstance].threeCodeSaved Success:^(NSArray *array) {
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

- (void)homeHeadViewCitySelete:(SOHomeHeadView *)view
{
    
    SOCityViewController *cityController = [[SOCityViewController alloc] initWithNibName:nil bundle:nil];
    [UIHelper tabController:self pushSubController:cityController];
}


- (void)homeHeadViewRelocation:(SOHomeHeadView *)view
{
    [[SOLocationManager shareInstance] startLocationService];
}



- (void)homeHeadViewScanning:(SOHomeHeadView *)view
{
    SOCodeReaderViewController *scanViweController = [[SOCodeReaderViewController alloc] initWithCancelButtonTitle:@"取消"];
    [UIHelper tabController:self pushSubController:scanViweController];
}


#pragma mark Delegate

- (void)locationManagerWillStart:(SOLocationManager *)manager
{
    [self.headView.cityLabel setTitle:NSLocalizedString(@"location.getting", nil) forState:UIControlStateNormal] ;
    
}
- (void)locationManagerDidStop:(SOLocationManager *)manager
{
//    [self.headView.cityLabel setTitle:NSLocalizedString(@"location.name.changing", nil) forState:UIControlStateNormal];

}
- (void)locationManager:(SOLocationManager *)manager getCityName:(NSString *)cityName threeCode:(NSString *)threeCode
{
    
    [self.headView.cityLabel setTitle:cityName forState:UIControlStateNormal];
    [self contentRefresh];
    
}
- (void)locationManager:(SOLocationManager *)manager error:(NSString *)error
{
    manager.citySaved = @"深圳";
    manager.threeCodeSaved = @"SZX";
    [self.headView.cityLabel setTitle:@"深圳" forState:UIControlStateNormal];
    [self contentRefresh];
}





- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([Env shareEnv].screenWidth * 120 /kStandardWidth )+15+5;
    
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    HomeTableCell *cell = [aTableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HomeTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[HotShop class]]) {
        HotShop *hotShop = (HotShop *)object;
        if (hotShop.shopPic != nil) {
            
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:hotShop.shopPic] placeholderImage:nil];
            
        }
        
//        "type.hotshop" = "热门餐厅";
//        "type.hotproduct" = "热门菜单";
//        "type.hotactivity" = "抢优惠";
        
        cell.typeIconView.image = [UIImage imageNamed:@"type_shop"];
        cell.typeNameLabel.text = NSLocalizedString(@"type.hotshop", nil);
        cell.productNameLabel.text = hotShop.shopName;
        
        if (hotShop.lastSign_headImg != nil) {
            
            [cell.singIconView sd_setImageWithURL:[NSURL URLWithString:hotShop.lastSign_headImg] placeholderImage:nil];
            
        }
        
        cell.singNameLable.text = hotShop.lastSign_nickName;
        cell.singTimeLabel.text = [NSString stringWithFormat:@"签到 %@",hotShop.lastSign_time];
    }else if([object isKindOfClass:[HotProduct class]]){
        
        HotProduct *hotShop = (HotProduct *)object;
        if (hotShop.productPic != nil) {
            
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:hotShop.productPic] placeholderImage:nil];
            
        }
        
        //        "type.hotshop" = "热门餐厅";
        //        "type.hotproduct" = "热门菜单";
        //        "type.hotactivity" = "抢优惠";
        
        cell.typeIconView.image = [UIImage imageNamed:@"type_product"];
        cell.typeNameLabel.text = NSLocalizedString(@"type.hotproduct", nil);
        cell.productNameLabel.text = hotShop.productName;
        
        if (hotShop.lastSign_headImg != nil) {
            
            [cell.singIconView sd_setImageWithURL:[NSURL URLWithString:hotShop.lastSign_headImg] placeholderImage:nil];
            
        }
        
        cell.singNameLable.text = hotShop.lastSign_nickName;
        cell.singTimeLabel.text = [NSString stringWithFormat:@"签到 %@",hotShop.lastSign_time];

        
    }else if([object isKindOfClass:[HotActivity class]]){
        
        HotActivity *hotShop = (HotActivity *)object;
        if (hotShop.activityPic != nil) {
            
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:hotShop.activityPic] placeholderImage:nil];
            
        }
        
        //        "type.hotshop" = "热门餐厅";
        //        "type.hotproduct" = "热门菜单";
        //        "type.hotactivity" = "抢优惠";
        
        cell.typeIconView.image = [UIImage imageNamed:@"type_activiety"];
        cell.typeNameLabel.text = NSLocalizedString(@"type.hotactivity", nil);
        cell.productNameLabel.text = hotShop.activityName;
        
        if (hotShop.lastSign_headImg != nil) {
            
            [cell.singIconView sd_setImageWithURL:[NSURL URLWithString:hotShop.lastSign_headImg] placeholderImage:nil];
            
        }
        
        cell.singNameLable.text = hotShop.lastSign_nickName;
        cell.singTimeLabel.text = [NSString stringWithFormat:@"签到 %@",hotShop.lastSign_time];
 
        
    }
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cantingListViewController *listcontroller = [[cantingListViewController alloc] initWithNibName:nil bundle:nil];
    [UIHelper tabController:self pushSubController:listcontroller];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
