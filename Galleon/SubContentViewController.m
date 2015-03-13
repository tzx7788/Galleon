//
//  SubContentViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 12/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "SubContentViewController.h"
#import "ImageConstant.h"

@interface SubContentViewController ()

@end

@implementation SubContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:BackButtonBackGround style:UIBarButtonItemStyleBordered target:self action:@selector(popBack)];
    [backBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
}

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
