//
//  SelectionViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 20/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "SelectionViewController.h"
#import "SelectionCell.h"

@interface SelectionViewController ()<UITableViewDataSource, UITableViewDelegate>


@end

@implementation SelectionViewController

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell" forIndexPath:indexPath];
    cell.dataLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.textField.text = self.dataArray[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
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
