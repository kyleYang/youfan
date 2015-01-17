//
//  SOLocationManager.m
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOLocationManager.h"
#import "BMKLocationService.h"

#define kBMKitAPPKEY @"iKOXtEX7lceTQkzKa9cdGepq"


#define kCitySavedKey @"citysavedkey"
#define kThreeCodeKey @"threecodekey"

@interface SOLocationManager()<BMKGeneralDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>


@property (nonatomic, strong, readwrite) BMKMapManager *manager;
@property (nonatomic, strong) BMKGeoCodeSearch *codeSearch;
@property (nonatomic, strong, readwrite) BMKLocationService  *locService;

@property (nonatomic, strong) NSArray *cities;

@end



@implementation SOLocationManager
@synthesize manager = _manager;
@synthesize locService = _locService;
@synthesize citySaved = _citySaved;
@synthesize threeCodeSaved = _threeCodeSaved;

static SOLocationManager *_shareInstance = nil;


+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _shareInstance = [[SOLocationManager alloc] init];
        
    });
    
    return _shareInstance;
    
}


- (instancetype)init
{
    if (self = [super init]) {
        
        
        _manager = [[BMKMapManager alloc]init];
        [_manager start:kBMKitAPPKEY generalDelegate:self];
        
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
        [BMKLocationService setLocationDistanceFilter:100.f];
        
    }
    
    return self;
    
}

- (void)autoLocationService
{
    if (self.threeCodeSaved == nil) {
        [self.locService startUserLocationService];
    }
}

- (void)startLocationService
{
    [self.locService startUserLocationService];
   
}



- (void)stopLocationService
{
     [self.locService stopUserLocationService];
}


#pragma mark property

- (BMKLocationService *)locService
{
    if (_locService != nil) {
        return _locService;
    }
    
     _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
    return _locService;
}


- (BMKGeoCodeSearch *)codeSearch
{
    if (_codeSearch != nil) {
        return _codeSearch;
    }
    
    _codeSearch = [[BMKGeoCodeSearch alloc] init];
    _codeSearch.delegate = self;
    return _codeSearch;
}


- (NSString *)citySaved
{
    if (_citySaved != nil) {
        return _citySaved;
    }
    
    _citySaved = [[NSUserDefaults standardUserDefaults] objectForKey:kCitySavedKey];
    return _citySaved;
}

- (void)setCitySaved:(NSString *)citySaved
{
    _citySaved = citySaved;
    
    [[NSUserDefaults standardUserDefaults] setObject:_citySaved forKey:kCitySavedKey];
    
}


- (NSString *)threeCodeSaved
{
    if (_threeCodeSaved != nil) {
        return _threeCodeSaved;
    }
    
    _threeCodeSaved = [[NSUserDefaults standardUserDefaults] objectForKey:kThreeCodeKey];
   
    return _threeCodeSaved;
}

- (void)setThreeCodeSaved:(NSString *)threeCodeSaved
{
    _threeCodeSaved = threeCodeSaved;
    
    [[NSUserDefaults standardUserDefaults] setObject:_threeCodeSaved forKey:kThreeCodeKey];
}



- (NSArray *)cities
{
    if (_cities != nil) {
        return _cities;
    }
    
    _cities = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"youfan_city" ofType:@"plist"]];
    return _cities;
    
}



- (void)onGetNetworkState:(int)iError;
{
    NSLog(@"onGetNetworkState :%d ",iError);
}
- (void)onGetPermissionState:(int)iError
{
    NSLog(@"onGetPermissionState :%d ",iError);
}

#pragma mark BMKLocationServiceDelegate

- (void)willStartLocatingUser;
{
    NSLog(@"willStartLocatingUser");
    if ([self.delegate respondsToSelector:@selector(locationManagerWillStart:)]) {
        [self.delegate locationManagerWillStart:self];
    }
}
- (void)didStopLocatingUser;
{
      NSLog(@"didStopLocatingUser");
    if ([self.delegate respondsToSelector:@selector(locationManagerDidStop:)]) {
        [self.delegate locationManagerDidStop:self];
    }
    
}
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation;
{
    
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation;
{
    NSLog(@"latitude--%f,longtitude---%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    CLLocationDegrees locaLatitude=userLocation.location.coordinate.latitude;//纬度
    CLLocationDegrees locaLongitude=userLocation.location.coordinate.longitude;//精度
    BMKCoordinateRegion region;
    //将定位的点居中显示
    region.center.latitude=locaLatitude;
    region.center.longitude=locaLongitude;
    
    //反地理编码出地理位置
    CLLocationCoordinate2D pt= userLocation.location.coordinate;
    BMKReverseGeoCodeOption *codeOption = [[BMKReverseGeoCodeOption alloc] init];
    codeOption.reverseGeoPoint = pt;
    
    BOOL flag = [self.codeSearch reverseGeoCode:codeOption];
    if (!flag) { //反转出错
        NSLog(@"reverseGeoCode fail");
        if([self.delegate respondsToSelector:@selector(locationManager:error:)]){
            [self.delegate locationManager:self error:NSLocalizedString(@"location.reverse.error", nil)];
        }
        
        [self stopLocationService];
        
        
    }
    
}
- (void)didFailToLocateUserWithError:(NSError *)error;
{
    NSLog(@"didFailToLocateUserWithError error:%@",error);
    if([self.delegate respondsToSelector:@selector(locationManager:error:)]){
        [self.delegate locationManager:self error:NSLocalizedString(@"location.reverse.error", nil)];
    }
     [self stopLocationService];
}



#pragma mark BMKGeoCodeSearchDelegate

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    NSLog(@"onGetReverseGeoCodeResult searcher:%@,result:%@,error:%d",searcher,result,error);
    if (BMK_SEARCH_NO_ERROR == error) {
        
        NSString *cityTotalName = result.addressDetail.city;
        
        NSRange range = [cityTotalName rangeOfString:@"市"];
        
        NSString *cityName = nil;
        
        if (range.location != NSNotFound) {
            cityName = [cityTotalName substringWithRange:NSMakeRange(0, range.location)];
        }else{
            cityName = cityTotalName;
        }
        
       __block NSString *threeCode = @"SZX"; //默认
       __block NSString *cityDefault = @"深圳";
        
        [self.cities enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            
            if ([[obj objectForKey:@"CityNameCn"] isEqualToString:cityName]) {
                threeCode = [obj objectForKey:@"CityThreeSign"];
                *stop = TRUE;
                cityDefault = cityName;
                
                 NSLog(@"find threecode %@ ",obj);
            }
            
        }];
        
        
        self.citySaved = cityDefault;
        self.threeCodeSaved = threeCode;
        
        
        if ([self.delegate respondsToSelector:@selector(locationManager:getCityName:threeCode:)]) {
            [self.delegate locationManager:self getCityName:cityDefault threeCode:threeCode];
        }
        
         [self stopLocationService];
        
        
    }else{
        NSLog(@"onGetReverseGeoCodeResult searcher:%@,result:%@,error:%d ---- fail",searcher,result,error);
        if([self.delegate respondsToSelector:@selector(locationManager:error:)]){
            [self.delegate locationManager:self error:NSLocalizedString(@"location.reverse.error", nil)];
        }
        
         [self stopLocationService];
    }
}



@end
