//
//  UpdateProfileViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 24/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "UpdateProfileViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface UpdateProfileViewController ()

@end

@implementation UpdateProfileViewController

+ (UpdateProfileViewController *) createViewController
{
    UpdateProfileViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UpdateProfileViewController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
