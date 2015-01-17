//
//  SOTableViewController.h
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOBaseViewController.h"

@interface SOTableViewController : SOBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) NSMutableArray *dataArray;

@end
