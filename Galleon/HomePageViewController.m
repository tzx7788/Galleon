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
#import "HomePageHeaderView.h"
#import "NewsTableViewCell.h"
#import "Client.h"
#import "NotificationConstant.h"

@interface HomePageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, strong) HomePageHeaderView * tableHeaderView;

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
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    self.tableHeaderView = [HomePageHeaderView createView];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidLayoutSubviews
{
    [self.tableView setTableHeaderView:self.tableHeaderView];
    
    [self.tableHeaderView setNeedsLayout];
    [self.tableHeaderView layoutIfNeeded];
    
    CGFloat height = [self.tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + self.tableHeaderView.frame.size.width * 0.5;
    
    
    CGRect headerFrame = self.tableHeaderView.frame;
    headerFrame.size.height = height;
    self.tableHeaderView.frame = headerFrame;
    
    [self.tableView setTableHeaderView:self.tableHeaderView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
        NSMutableIndexSet * indexSet = [NSMutableIndexSet indexSet];
        [indexSet addIndex:0];
        //[indexSet addIndex:1];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } failureBlock:nil];
    [[Client sharedClient] getNewsWithsuccessBlock:^(id responseObject){
        NSArray * array = responseObject;
        NSMutableArray * modelList = self.dataArray[1];
        [modelList removeAllObjects];
        int count = 0;
        for (id object in array){
            count ++;
            if ( count > 3 ) break;
            NewsModel * model = [[NewsModel alloc] init];
            [model loadDataWithDictionary:object];
            [modelList addObject:model];
        }
        NSMutableIndexSet * indexSet = [NSMutableIndexSet indexSet];
        //[indexSet addIndex:0];
        [indexSet addIndex:1];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } failureBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NewsTableViewCell * newscell;
    if (newscell == nil) {
        newscell = [tableView dequeueReusableCellWithIdentifier: @"NewsTableViewCell"];
    }
    static InformTableViewCell * headercell;
    if (headercell == nil) {
        headercell = [tableView dequeueReusableCellWithIdentifier: @"InformTableViewCell"];
    }
    if ( indexPath.section == 0 ) {
        [headercell setModel:self.dataArray[indexPath.section][indexPath.row]];
        return [headercell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height + 1.0f;
    } else if ( indexPath.section == 1 ) {
        [newscell setModel:self.dataArray[indexPath.section][indexPath.row]];
        return [newscell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height + 1.0f;
    }
    return 0;
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
    } else if ( indexPath.section == 1 ){
        NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
        NewsModel * model = self.dataArray[indexPath.section][indexPath.row];
        [cell setModel:model];
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@""];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNewsDetailClicked object:self.dataArray[indexPath.section][indexPath.row]];
    [cell setSelected:NO];
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
