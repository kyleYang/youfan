//
//  SOLocationManager.h
//  youfan
//
//  Created by Kyle on 14/12/31.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@protocol locationManageDlegate ;

@interface SOLocationManager : NSObject

@property (nonatomic, weak_delegate) id<locationManageDlegate> delegate;

@property (nonatomic, strong, readonly) BMKMapManager *manager;
@property (nonatomic, strong, readonly) BMKLocationService  *locService;

@property (nonatomic, readonly) NSArray *cities;

@property (nonatomic, strong) NSString *citySaved;
@property (nonatomic, strong) NSString *threeCodeSaved;

@property (nonatomic, strong) NSString *cityTemp;
@property (nonatomic, strong) NSString *threeCodeTemp;



+(instancetype)shareInstance;

- (void)autoLocationService;
- (void)startLocationService;
- (void)stopLocationService;


@end


@protocol locationManageDlegate <NSObject>

- (void)locationManagerWillStart:(SOLocationManager *)manager;
- (void)locationManagerDidStop:(SOLocationManager *)manager;
- (void)locationManager:(SOLocationManager *)manager getCityName:(NSString *)cityName threeCode:(NSString *)threeCode;
- (void)locationManager:(SOLocationManager *)manager error:(NSString *)error;

@end

