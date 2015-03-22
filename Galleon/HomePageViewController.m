//
//  HomePageViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "HomePageViewController.h"
#import "InformHeaderView.h"
#import "HeadLineHeaderView.h"
#import "InformTableViewCell.h"
#import "Client.h"

@interface HomePageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation HomePageViewController

- (NSArray *)dataArray
{
    if (!_dataArray){
        _dataArray = @[[[NSMutableArray alloc]init],[[NSMutableArray alloc]init]];
    }
    return _dataArray;
}

+ (HomePageViewController *)createViewController
{
    HomePageViewController * vc = [[HomePageViewController alloc] initWithNibName:@"HomePageViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"InformHeaderView"  bundle:nil] forHeaderFooterViewReuseIdentifier:@"InformHeaderView"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HeadLineHeaderView"  bundle:nil] forHeaderFooterViewReuseIdentifier:@"HeadLineHeaderView"];
    [self.tableView registerNib:[UINib nibWithNibName:@"InformTableViewCell" bundle:nil] forCellReuseIdentifier:@"InformTableViewCell"];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadData
{
    [[Client sharedClient] getAllInformsWithsuccessBlock:^(id responseData){
        NSMutableArray * modelList = self.dataArray[0];
        [modelList removeAllObjects];
        NSArray * array = responseData;
        for ( id dict in array )
        {
            InformModel * model = [[InformModel alloc] init];
            if ( dict[@"title"] ) model.title = dict[@"title"];
            if ( dict[@"create_time"] ) model.createdTime = dict[@"create_time"];
            if ( dict[@"id"] ) model.informId = dict[@"id"];
            [modelList addObject:model];
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failureBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString * identifier;
    switch (section) {
        case 0:
            identifier = @"InformHeaderView";
            break;
        case 1:
            identifier = @"HeadLineHeaderView";
            break;
        default:
            break;
    }
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section == 0 ) {
        InformTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InformTableViewCell" forIndexPath:indexPath];
        InformModel * model = self.dataArray[indexPath.section][indexPath.row];
        [cell setModel:model];
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@""];
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
