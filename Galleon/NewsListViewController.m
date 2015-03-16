//
//  NewsListViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"
#import "Client.h"

@interface NewsListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * modelList;

@end

@implementation NewsListViewController

+ (NewsListViewController *)createViewController
{
    NewsListViewController * vc = [[NewsListViewController alloc] initWithNibName:@"NewsListViewController" bundle:nil];
    return vc;
}

- (NSMutableArray *)modelList
{
    if ( !_modelList ) {
        _modelList = [[NSMutableArray alloc] init];
    }
    return _modelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self loadData];
}

- (void)loadData
{
    [[Client sharedClient] getNewsWithsuccessBlock:^(id responseObject){
        self.modelList = nil;
        NSArray * array = responseObject;
        for (id object in array){
            NewsModel * model = [[NewsModel alloc] init];
            model.titleString = object[@"title"];
            model.avatarURLString = object[@"icon"];
            model.date = object[@"create_time"];
            [self.modelList addObject:model];
        }
        [self.tableView reloadData];
    } failureBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NewsTableViewCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
    NewsTableViewCell * cell = [NewsTableViewCell createCell];
    if (!cell) {
        cell = [NewsTableViewCell createCell];
    }
    [cell setModel:self.modelList[indexPath.row]];
    return cell;
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
