//
//  PersonViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "PersonViewController.h"
#import "NotificationConstant.h"

@interface PersonViewController ()

@end

@implementation PersonViewController

+ (PersonViewController *)createViewController
{
    PersonViewController * vc = [[PersonViewController alloc] initWithNibName:@"PersonViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [[self.editButton layer] setBorderWidth:1.0f];
    [[self.editButton layer] setBorderColor:CGColorCreateCopyWithAlpha([UIColor whiteColor].CGColor, 0.7)];
    [[self.editButton layer] setCornerRadius:self.editButton.frame.size.height/2];
    [[self.logoutButton layer] setBorderWidth:1.0f];
    [[self.logoutButton layer] setBorderColor:CGColorCreateCopyWithAlpha([UIColor whiteColor].CGColor, 0.7)];
    [[self.logoutButton layer] setCornerRadius:self.logoutButton.frame.size.height/2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateProfile object:self.model];
}

- (IBAction)logoutClicked:(id)sender {
    self.model.user.password = @"";
    self.model.user.autoLogin = [NSNumber numberWithBool:NO];
    [User saveToCache:self.model.user];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginIn object:nil];
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
