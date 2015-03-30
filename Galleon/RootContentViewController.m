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
#import "TitleLabel.h"
#import "ExhibitionModel.h"
#import "ExhibitionListModel.h"
#import "StringConstant.h"
#import "ExhibitionListViewController.h"
#import "NewsListModel.h"
#import "NewsListViewController.h"
#import "AboutModel.h"
#import "AboutViewController.h"
#import "HomePageModel.h"
#import "HomePageViewController.h"
#import "DiscussModel.h"
#import "DiscussViewController.h"
#import "PersonModel.h"
#import "PersonViewController.h"
#import "SupplierModel.h"
#import "SupplierViewController.h"

@interface RootContentViewController ()
@end

@implementation RootContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem * homeButtonItem = [[UIBarButtonItem alloc] initWithImage:HomeButtonBackGround style:UIBarButtonItemStyleBordered target:self action:@selector(showLeftMenu)];
    [homeButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = homeButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadExhibitionListViewController:) name:NotificationExhibitionListClicked object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewsListViewController:) name:NotificationNewsClicked object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadAboutViewController:) name:NotificationAboutClicked object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadHomePageViewController:) name:NotificationHomePageClicked object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDiscussViewController:) name:NotificationDiscussClicked object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPersonPageViewController:) name:NotificationPersonPageClicked object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadSupplierViewController:) name:NotificationSupplierClicked object:nil];
    
}

- (void) finalize
{
    [super finalize];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationExhibitionListClicked object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationNewsClicked object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationAboutClicked object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationHomePageClicked object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationDiscussClicked object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationPersonPageClicked object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationSupplierClicked object:nil];
}

- (void)loadSupplierViewController:(NSNotification *) notification
{
    if ( [[notification object] isKindOfClass:[SupplierModel class]] ) {
        TitleLabel * label = [TitleLabel createLabel];
        label.text = Supplier;
        self.navigationItem.titleView = label;
        SupplierViewController * vc = [SupplierViewController createViewController];
        vc.model = [notification object];
        [self loadViewController:vc];
    }
}


- (void)loadPersonPageViewController:(NSNotification *) notification
{
    if ( [[notification object] isKindOfClass:[PersonModel class]] ) {
        TitleLabel * label = [TitleLabel createLabel];
        label.text = Person;
        self.navigationItem.titleView = label;
        PersonViewController * vc = [PersonViewController createViewController];
        vc.model = [notification object];
        [self loadViewController:vc];
    }
}


- (void)loadHomePageViewController:(NSNotification *) notification
{
    if ( [[notification object] isKindOfClass:[HomePageModel class]] ) {
        TitleLabel * label = [TitleLabel createLabel];
        label.text = HomePage;
        self.navigationItem.titleView = label;
    }
    [self loadViewController:[HomePageViewController createViewController]];
}

- (void)loadDiscussViewController:(NSNotification *) notification
{
    User * user = [User awakeFromCache];
    if ( [user.isVIP boolValue] == NO ){
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWarningMessage object:PermissionDenied];
        return;
    }
    if ( [[notification object] isKindOfClass:[DiscussModel class]] ) {
        TitleLabel * label = [TitleLabel createLabel];
        label.text = Discuss;
        self.navigationItem.titleView = label;
    }
    [self loadViewController:[DiscussViewController createViewController]];
}



- (void)loadAboutViewController:(NSNotification *) notification
{
    if ( [[notification object] isKindOfClass:[AboutModel class]] ) {
        TitleLabel * label = [TitleLabel createLabel];
        label.text = AboutUs;
        self.navigationItem.titleView = label;
    }
    [self loadViewController:[AboutViewController createViewController]];
}


- (void)loadNewsListViewController:(NSNotification *) notification
{
    if ( [[notification object] isKindOfClass:[NewsListModel class]] ) {
        TitleLabel * label = [TitleLabel createLabel];
        label.text = News;
        self.navigationItem.titleView = label;
    }
    [self loadViewController:[NewsListViewController createViewController]];
}

- (void)loadExhibitionListViewController:(NSNotification *)notification
{
    if ( [[notification object] isKindOfClass:[ExhibitionListModel class]] ) {
        //ExhibitionListModel * model = [notification object];
        TitleLabel * label = [TitleLabel createLabel];
        label.text = Exhibition;
        self.navigationItem.titleView = label;
        
    }
    [self loadViewController:[ExhibitionListViewController createViewController]];
}

- (void)loadViewController:(UIViewController *) vc
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
