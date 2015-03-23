//
//  ExhibitionViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionViewController.h"
#import "ExhibitionTableViewCell.h"
#import "TitleLabel.h"
#import "TitleLabel.h"
#import "NotificationConstant.h"
#import "PDFModel.h"
#import "ExhibitionDetailModel.h"
#import "ExhibitionFileListModel.h"
#import "Client.h"

@interface ExhibitionViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ExhibitionViewController

+ (ExhibitionViewController *)createViewController
{
    ExhibitionViewController * vc;
    vc = [[ExhibitionViewController alloc] initWithNibName:@"ExhibitionViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TitleLabel * titleLabel = [TitleLabel createLabel];
    titleLabel = [TitleLabel createLabel];
    titleLabel.text = self.model.exhibitionName;
    self.navigationItem.titleView = titleLabel;
    [self.tableView registerNib:[UINib nibWithNibName:@"ExhibitionTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExhibitionTableViewCell"];
    [self.tableView setHidden:YES];
    [self loadData];
}

- (void)loadData
{
    [[Client sharedClient] getExhibitionWithId:self.model.exhibitionId successBlock:^(id responseData) {
        [self.model loadWithDictionary:responseData];
        [self.tableView setHidden:NO];
    }failureBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ExhibitionTableViewCellRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitionTableViewCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"ExhibitionTableViewCell" forIndexPath:indexPath];
    ExhibitionType * type = [[ExhibitionType alloc] init];
    switch (indexPath.row) {
        case 0:
            type.type = ExhibitionTypeIntro;
            [cell setType:type];
            break;
        case 1:
            type.type = ExhibitionTypeService;
            [cell setType:type];
            break;
        case 2:
            type.type = ExhibitionTypeHost;
            [cell setType:type];
            break;
        case 3:
            type.type = ExhibitionTypeSche;
            [cell setType:type];
            break;
        case 4:
            type.type = ExhibitionTypeLayout;
            [cell setType:type];
            break;
        case 5:
            type.type = ExhibitionTypeDownload;
            [cell setType:type];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitionTableViewCell * cell  = (ExhibitionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    ExhibtionCategoryType type = cell.type.type;
    switch (type) {
        case ExhibitionTypeIntro:
        {
            ExhibitionDetailModel * model = [[ExhibitionDetailModel alloc] init];
            model.title = cell.type.name;
            model.content = self.model.introContent;
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationExhibitionDeitail object:model];
        }
            break;
        case ExhibitionTypeService:
        {
            ExhibitionDetailModel * model = [[ExhibitionDetailModel alloc] init];
            model.title = cell.type.name;
            model.content = self.model.serviceContent;
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationExhibitionDeitail object:model];
        }
            break;
        case ExhibitionTypeHost:
        {
            ExhibitionDetailModel * model = [[ExhibitionDetailModel alloc] init];
            model.title = cell.type.name;
            model.content = self.model.hostContent;
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationExhibitionDeitail object:model];
        }
            break;
        case ExhibitionTypeSche:
        {
            ExhibitionDetailModel * model = [[ExhibitionDetailModel alloc] init];
            model.title = cell.type.name;
            model.content = self.model.scheduleContent;
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationExhibitionDeitail object:model];
        }
            break;
        case ExhibitionTypeLayout:
        {
            ExhibitionDetailModel * model = [[ExhibitionDetailModel alloc] init];
            model.title = cell.type.name;
            model.content = self.model.layoutContent;
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationExhibitionDeitail object:model];
        }
            break;
        case ExhibitionTypeDownload:
        {
            ExhibitionFileListModel * model = [[ExhibitionFileListModel alloc] init];
            model.title = cell.type.name;
            model.exhibitionId = self.model.exhibitionId;
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationExhibitionFileList object:model];
        }
            break;
        default:
            break;
    }
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
