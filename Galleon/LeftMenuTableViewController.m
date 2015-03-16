//
//  LeftMenuTableViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 11/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "LeftMenuTableViewController.h"
#import "LeftMenuTableViewCell.h"
#import "NotificationConstant.h"
#import "ExhibitionListModel.h"
#import "LeftMenuUserHeaderView.h"
#import "NewsListModel.h"

@interface LeftMenuTableViewController ()

@end

@implementation LeftMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setScrollEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return LeftMenuUserHeaderViewHeight;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [LeftMenuUserHeaderView createView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftMenuTableViewCell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.type = LeftMenuTableViewCellHomePage;
            break;
        case 1:
            cell.type = LeftMenuTableViewCellNews;
            break;
        case 2:
            cell.type = LeftMenuTableViewCellExhibition;
            break;
        case 3:
            cell.type = LeftMenuTableViewCellDiscuss;
            break;
        case 4:
            cell.type = LeftMenuTableViewCellAbout;
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftMenuTableViewCell * cell = (LeftMenuTableViewCell * )[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    switch (cell.type) {
        case LeftMenuTableViewCellHomePage:
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHomePageClicked object:nil];
            break;
        case LeftMenuTableViewCellNews:
        {
            NewsListModel * model = [[NewsListModel alloc] init];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNewsClicked object:model];
        }
            break;
        case LeftMenuTableViewCellExhibition:
        {
            ExhibitionListModel * model = [[ExhibitionListModel alloc] init];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationExhibitionListClicked object:model];
        }
            break;
        case LeftMenuTableViewCellDiscuss:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationDiscussClicked object:nil];
        }
            break;
        case LeftMenuTableViewCellAbout:
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationAboutClicked object:nil];
            break;
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationShowContent object:nil];
}

@end
