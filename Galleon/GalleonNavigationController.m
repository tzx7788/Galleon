//
//  GalleonNavigationController.m
//  Galleon
//
//  Created by Tang Zhixiong on 14/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "GalleonNavigationController.h"

#import "NotificationConstant.h"

#import "SubContentViewController.h"
#import "ExhibitionViewController.h"
#import "ExhibitionModel.h"
#import "NewsViewController.h"
#import "NewsModel.h"

@interface GalleonNavigationController ()

@end

@implementation GalleonNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exhibitionclicked:) name:NotificationExhibitionClicked object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newsDetailClicked:) name:NotificationNewsDetailClicked object:nil];
}

- (void) finalize
{
    [super finalize];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationExhibitionClicked object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationNewsDetailClicked object:nil];
}

- (void)newsDetailClicked:(NSNotification *) notification
{
    if ( [[notification object] isKindOfClass:[NewsModel class]] ) {
        NewsModel *model = [notification object];
        SubContentViewController * svc = [SubContentViewController createViewController];
        TitleLabel * label = [TitleLabel createLabel];
        label.text = model.titleString;
        self.navigationItem.titleView = label;
        svc.titleLabel = label;
        NewsViewController * vc = [NewsViewController createViewController];
        svc.contentViewController = vc;
        vc.model = model;
        [self pushViewController:svc animated:YES];
    }
}

- (void)exhibitionclicked:(NSNotification *) notification
{
    if ( [[notification object] isKindOfClass:[ExhibitionModel class]] ) {
        ExhibitionModel * model = [notification object];
        SubContentViewController * svc = [SubContentViewController createViewController];
        TitleLabel * label = [TitleLabel createLabel];
        label.text = model.exhibitionName;
        self.navigationItem.titleView = label;
        svc.titleLabel = label;
        ExhibitionViewController * vc = [ExhibitionViewController createViewController];
        svc.contentViewController = vc;
        vc.model = model;
        [self pushViewController:svc animated:YES];
    }
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
