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
    ExhibitionModel *model = [[ExhibitionModel  alloc] init];
    model.exhibitionName = @"一个论坛";
    model.titleImageURLString = @"/Users/tzx/Documents/Galleon/Galleon/pic_1huiyijieshao.png";
    [self.modelList addObject:model];
    model = [[ExhibitionModel  alloc] init];
    model.exhibitionName = @"两个论坛";
    model.titleImageURLString = @"pic_6lijiehuiyibaogao";
    [self.modelList addObject:model];
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
