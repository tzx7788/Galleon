//
//  ExhibitionListViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionListViewController.h"
#import "ExhibitionListTableViewCell.h"
#import "NotificationConstant.h"
#import "Client.h"

@interface ExhibitionListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * modelList;

@end

@implementation ExhibitionListViewController

+ (ExhibitionListViewController *)createViewController
{
    ExhibitionListViewController * vc = [[ExhibitionListViewController alloc] initWithNibName:@"ExhibitionListViewController" bundle:nil];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"ExhibitionListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExhibitionListTableViewCell"];
    [self loadData];
}

- (void)loadData
{
    [[Client sharedClient] getAllExhibitionsWithsuccessBlock:^(id responseData){
        NSArray * array = responseData;
        NSMutableArray * modelList = [[NSMutableArray alloc] init];
        for ( id dict in array ){
            ExhibitionModel * model = [[ExhibitionModel alloc] init];
            if (dict[@"view_count"]) model.viewCount = dict[@"view_count"];
            if (dict[@"started_time"]) model.startedTime = dict[@"started_time"];
            if (dict[@"updated_time"]) model.updatedTime = dict[@"updated_time"];
            if (dict[@"created_time"]) model.createdTime = dict[@"created_time"];
            if (dict[@"id"]) model.exhibitionId = dict[@"id"];
            if (dict[@"title"]) model.exhibitionName = dict[@"title"];
            [modelList addObject:model];
        }
        self.modelList = [modelList copy];
        [self.tableView reloadData];
    }failureBlock:^(NSError *error, NSString * responseString) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ExhibitionListTableViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.modelList count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitionListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ExhibitionListTableViewCell" forIndexPath:indexPath];
    ExhibitionModel * model = [self.modelList objectAtIndex:indexPath.row];
    [cell setExhibitionModel:model];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitionListTableViewCell * cell = (ExhibitionListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationExhibitionClicked object:cell.exhibitionModel];
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
