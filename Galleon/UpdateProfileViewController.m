//
//  UpdateProfileViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 24/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "UpdateProfileViewController.h"

@interface UpdateProfileViewController ()

@end

@implementation UpdateProfileViewController

+ (UpdateProfileViewController *) createViewController
{
    UpdateProfileViewController * vc = [[UpdateProfileViewController alloc] initWithNibName:@"UpdateProfileViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
