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
#import "PDFViewController.h"
#import "PDFModel.h"
#import "PostMessageModel.h"
#import "PostMessageViewController.h"
#import "StringConstant.h"
#import "NewsListModel.h"
#import "NewsListViewController.h"
#import "ExhibitionFileListViewController.h"
#import "ExhibitionDetailViewController.h"
#import "UpdateProfileViewController.h"
#import "SuperPushNotification.h"
#import "SuperViewController.h"

@interface GalleonNavigationController ()

@end

@implementation GalleonNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotification:) name:NotificationPush object:nil];
}

- (void) finalize
{
    [super finalize];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationPush object:nil];
}

- (void)pushNotification:(NSNotification *)notification
{
    if ( [[notification object] isKindOfClass:[SuperPushNotification class]] ) {
        SuperPushNotification * superNotification = [notification object];
        SubContentViewController * svc = [SubContentViewController createViewController];
        TitleLabel * label = [TitleLabel createLabel];
        label.text = superNotification.title;
        self.navigationItem.titleView = label;
        svc.titleLabel = label;
        Class class = NSClassFromString(superNotification.viewControllerClassName);
        if ( [class isSubclassOfClass:SuperViewController.class] ) {
            SuperViewController * vc = [class createViewController];
            svc.contentViewController = vc;
            vc.model = superNotification.model;
            [self pushViewController:svc animated:YES];
        }
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
