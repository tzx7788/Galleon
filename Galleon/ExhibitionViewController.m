//
//  ExhibitionViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionViewController.h"
#import "ExhibitionTableViewCell.h"

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
    [self.tableView registerClass:[ExhibitionTableViewCell class] forCellReuseIdentifier:@"ExhibitionTableViewCell"];
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
    cell = [tableView dequeueReusableCellWithIdentifier:@"ExhibitionTableViewCell"];
    if ( cell != NULL)
        cell = [ExhibitionTableViewCell createCell];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
