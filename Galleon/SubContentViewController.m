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

+(SubContentViewController *)createViewController
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SubContentViewController"];
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    if ( _contentViewController && [self isViewLoaded] ) {
        [_contentViewController removeFromParentViewController];
        [_contentViewController.view removeFromSuperview];
    }
    if ( [self isViewLoaded] ) {
        [self addChildViewController:contentViewController];
        CGRect frame = self.view.bounds;
        frame.size.height -= self.navigationController.navigationBar.bounds.size.height+20;
        frame.origin.y += self.navigationController.navigationBar.bounds.size.height+20;
        [_contentViewController.view setFrame:frame];
        [self.view addSubview:_contentViewController.view];
    }
    _contentViewController = contentViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.titleView = self.titleLabel;
    UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:BackButtonBackGround style:UIBarButtonItemStyleBordered target:self action:@selector(popBack)];
    [backBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    self.contentViewController = self.contentViewController;
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
