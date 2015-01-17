//
//  SOTableViewController.m
//  youfan
//
//  Created by Kyle on 14/12/27.
//  Copyright (c) 2014年 7Orange. All rights reserved.
//

#import "SOTableViewController.h"

@interface SOTableViewController ()

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;
@end

@implementation SOTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.scrollsToTop = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.allowsSelection = YES;
    self.tableView.allowsSelectionDuringEditing = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.backgroundView = nil;
    [self.view addSubview:self.tableView];

    
}


- (NSMutableArray *)dataArray
{
    if (_dataArray != nil) {
        return _dataArray;
    }
    
    _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}

#pragma mark ------------
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 10;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
