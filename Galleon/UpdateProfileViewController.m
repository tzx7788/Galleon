//
//  UpdateProfileViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 24/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "UpdateProfileViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "NotificationConstant.h"
#import "StringConstant.h"
#import <MBProgressHUD.h>
#import "Client.h"

@interface UpdateProfileViewController ()<MBProgressHUDDelegate>

@end

@implementation UpdateProfileViewController

+ (UpdateProfileViewController *) createViewController
{
    UpdateProfileViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UpdateProfileViewController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.accountTextField setEnabled:NO];
    [self initTextField];
}

- (void) initTextField
{
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:self.model.user.iconImageURLString]];
    self.nameTextField.text = self.model.user.name;
    self.accountTextField.text = self.model.user.account;
    self.campanyTextField.text = self.model.user.company;
    self.passwordTextField.text = self.model.user.password;
    self.confirmPasswordTextField.text = self.model.user.password;
    self.jobTextField.text = self.model.user.job;
    self.phoneTextField.text = self.model.user.phone;
    self.emailTextField.text = self.model.user.email;
}

- (IBAction)ComfirmClicked:(id)sender {
    if ([super verified]) {
        NSString * message = Updating;
        MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.delegate = self;
        hud.dimBackground = YES;
        hud.square = YES;
        hud.labelText = message;
        hud.mode = MBProgressHUDModeIndeterminate;
        [hud show:YES];
        [[Client sharedClient] updateUserWithName:self.nameTextField.text
                                           userId:self.model.user.userId
                                            token:self.model.user.token
                                         password:self.passwordTextField.text
                                      headerImage:self.headerName
                                          company:self.campanyTextField.text
                                              job:self.jobTextField.text
                                            phone:self.phoneTextField.text
                                            email:self.emailTextField.text
                                   successBlock:^(id responseData){
                                       User * user = [[User alloc] init];
                                       [user loadWithDictionary:responseData];
                                       user.password = self.passwordTextField.text;
                                       [User saveToCache:user];
                                       hud.mode = MBProgressHUDModeText;
                                       PersonModel * model = [[PersonModel alloc] init];
                                       model.user = user;
                                       [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWarningMessage object:UpdateSuccessful];
                                       [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPersonPageClicked object:model];
                                       [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLeftMenuUserRefresh object:nil];
                                   } failureBlock:^(NSError *error, NSString * errorString){
                                       hud.mode = MBProgressHUDModeText;
                                       hud.labelText = UpdateFailure;
                                       [hud hide:YES afterDelay:1];
                                   }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MBProgressHUDDeleagte
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
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
