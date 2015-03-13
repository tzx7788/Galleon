//
//  RootContentViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 12/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "RootContentViewController.h"
#import "NotificationConstant.h"
#import "ImageConstant.h"
#import "NotificationConstant.h"
#import "ExhibitionViewController.h"

@interface RootContentViewController ()

@end

@implementation RootContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * homeButtonItem = [[UIBarButtonItem alloc] initWithImage:HomeButtonBackGround style:UIBarButtonItemStyleBordered target:self action:@selector(showLeftMenu)];
    [homeButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = homeButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadExhibitionViewController) name:NotificationExhibitionClicked object:nil];
}

- (void) finalize
{
    [super finalize];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationExhibitionClicked object:nil];
}

- (void)loadExhibitionViewController
{
    [self loadViewController:[ExhibitionViewController createViewController]];
}

- (void)loadViewController:(UIViewController *) vc
{
    if (self.contentController){
        [self.contentController.view removeFromSuperview];
        [self.contentController removeFromParentViewController];
    }
    self.contentController = vc;
    [self addChildViewController:self.contentController];
    CGRect frame = self.view.bounds;
    frame.size.height -= self.navigationController.navigationBar.bounds.size.height+20;
    frame.origin.y += self.navigationController.navigationBar.bounds.size.height+20;
    [self.contentController.view setFrame:frame];
    [self.view addSubview:self.contentController.view];
}

- (void)showLeftMenu
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationShowLeftMenu object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClicked:(id)sender {
    //[self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SubContentViewController"]animated:YES];
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
