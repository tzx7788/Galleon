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
#import "NotificationConstant.h"

@interface NewsListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray * modelList;

@end

@implementation NewsListViewController

+ (NewsListViewController *)createViewController
{
    NewsListViewController * vc = [[NewsListViewController alloc] initWithNibName:@"NewsListViewController" bundle:nil];
    return vc;
}

- (NSArray *)modelList
{
    if ( !_modelList ) {
        _modelList = [[NSArray alloc] init];
    }
    return _modelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self loadData];
}

- (void)loadData
{
    [[Client sharedClient] getNewsWithsuccessBlock:^(id responseObject){
        NSArray * array = responseObject;
        NSMutableArray * modelArray = [[NSMutableArray alloc] init];
        for (id object in array){
            NewsModel * model = [[NewsModel alloc] init];
            model.newsId = object[@"id"];
            model.titleString = object[@"title"];
            model.avatarURLString = object[@"icon"];
            model.date = object[@"create_time"];
            model.hasVideo = [object[@"has_video"] boolValue];
            model.videoURLString = object[@"video_link"];
            [modelArray addObject:model];
        }
        self.modelList = [modelArray sortedArrayUsingComparator:^(id obj1, id obj2){
            NewsModel * a = (NewsModel *)obj1;
            NewsModel * b = (NewsModel *)obj2;
            return [b.date compare:a.date];
        }];
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
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [NewsTableViewCell createCell];
    }
    [cell setModel:self.modelList[indexPath.row]];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNewsDetailClicked object:self.modelList[indexPath.row]];
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
