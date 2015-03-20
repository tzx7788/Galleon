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

@interface HomePageViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation HomePageViewController

+ (HomePageViewController *)createViewController
{
    HomePageViewController * vc = [[HomePageViewController alloc] initWithNibName:@"HomePageViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"InformHeaderView"  bundle:nil] forHeaderFooterViewReuseIdentifier:@"InformHeaderView"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HeadLineHeaderView"  bundle:nil] forHeaderFooterViewReuseIdentifier:@"HeadLineHeaderView"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
