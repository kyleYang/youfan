//
//  SOCityViewController.m
//  youfan
//
//  Created by Kyle on 15/1/1.
//  Copyright (c) 2015年 7Orange. All rights reserved.
//

#import "SOCityViewController.h"
#import "SOLocationManager.h"
#import "Env.h"
#import "SOCityTableCell.h"

@interface SOCityViewController()



@end

@implementation SOCityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor grayColor];
    self.tableView.allowsSelection = TRUE;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = FALSE;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return [[SOLocationManager shareInstance].cities count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
    
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    SOCityTableCell *cell = [aTableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SOCityTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSDictionary *sub = [[SOLocationManager shareInstance].cities objectAtIndex:indexPath.row];
    cell.cityLabel.text = [sub objectForKey:@"CityNameCn"];
    
    if ([[sub objectForKey:@"CityThreeSign"] isEqualToString:[SOLocationManager shareInstance].threeCodeSaved]) {
        cell.seleteImageView.hidden = FALSE;
    }else{
        cell.seleteImageView.hidden = TRUE;
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < [[SOLocationManager shareInstance].cities count]) {
        
        NSDictionary *sub = [[SOLocationManager shareInstance].cities objectAtIndex:indexPath.row];
        [SOLocationManager shareInstance].citySaved = [sub objectForKey:@"CityNameCn"];
        [SOLocationManager shareInstance].threeCodeSaved = [sub objectForKey:@"CityThreeSign"];
        
        [tableView reloadData];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}




@end
