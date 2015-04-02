//
//  LoginViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 14/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "Client.h"
#import "StringConstant.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "NotificationConstant.h"
#import "PersonModel.h"

@interface LoginViewController ()<MBProgressHUDDelegate,UITextFieldDelegate>
@property (nonatomic, strong) User * user;
@property (nonatomic, assign) BOOL isPasswordVisible;
@end

@implementation LoginViewController

- (void)setIsPasswordVisible:(BOOL)isPasswordVisible
{
    _isPasswordVisible = isPasswordVisible;
    if ( _isPasswordVisible ) {
        [self.peekButton setBackgroundImage:[UIImage imageNamed:@"ic_input_box_visible"] forState:UIControlStateNormal];
    } else {
        [self.peekButton setBackgroundImage:[UIImage imageNamed:@"ic_input_box_invisible"] forState:UIControlStateNormal];
    }
    [self.passwordTextField setSecureTextEntry:!_isPasswordVisible];
}

- (void) setUser:(User *)user
{
    _user = user;
    self.accountTextField.text = user.account;
    self.passwordTextField.text = user.password;
    [self refreshAutoLoginButton:[user.autoLogin boolValue]];
    self.isPasswordVisible = NO;
}

- (void)refreshAutoLoginButton:(BOOL)isSelected
{
    if ( isSelected ) {
        [self.autoLoginButton setBackgroundImage:[UIImage imageNamed:@"ic_checked_normal"] forState:UIControlStateNormal];
        [self.autoLoginButton setBackgroundImage:[UIImage imageNamed:@"ic_checked_pressed"] forState:UIControlStateHighlighted];
    } else {
        [self.autoLoginButton setBackgroundImage:[UIImage imageNamed:@"ic_unchecked_normal"] forState:UIControlStateNormal];
        [self.autoLoginButton setBackgroundImage:[UIImage imageNamed:@"ic_unchecked_press"] forState:UIControlStateHighlighted];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [User awakeFromCache];
    [[self.accountView layer] setBorderWidth:1.0f];
    [[self.accountView layer] setBorderColor:CGColorCreateCopyWithAlpha([UIColor whiteColor].CGColor, 0.3f)];
    [[self.accountView layer] setCornerRadius:20.0f];
    [[self.passwordView layer] setBorderWidth:1.0f];
    [[self.passwordView layer] setBorderColor:CGColorCreateCopyWithAlpha([UIColor whiteColor].CGColor, 0.3f)];
    [[self.passwordView layer] setCornerRadius:20.0f];
    [[self.loginButton layer] setBorderWidth:1.0f];
    [[self.loginButton layer] setBorderColor:CGColorCreateCopyWithAlpha([UIColor whiteColor].CGColor, 0.3f)];
    [[self.loginButton layer] setCornerRadius:20.0f];
    [[self.registerButton layer] setBorderWidth:1.0f];
    [[self.registerButton layer] setBorderColor:CGColorCreateCopyWithAlpha([UIColor whiteColor].CGColor, 0.3f)];
    [[self.registerButton layer] setCornerRadius:20.0f];
    if ( self.user.account && self.user.password && [self.user.autoLogin boolValue] )
        [self loginWithAccount:self.user.account password:self.user.password];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)autoLoginClicked:(id)sender {
    BOOL isAutoLogin = [self.user.autoLogin boolValue];
    self.user.autoLogin = [NSNumber numberWithBool:!isAutoLogin];
    [self refreshAutoLoginButton:!isAutoLogin];
}

- (IBAction)LoginClicked:(id)sender {
    [self loginWithAccount:self.accountTextField.text password:self.passwordTextField.text];
}

- (void)loginWithAccount:(NSString *) account
                password:(NSString *) password
{
    NSString * message =Logging;
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.delegate = self;
    hud.dimBackground = YES;
    hud.square = YES;
    hud.labelText = message;
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud show:YES];
    [[Client sharedClient] loginWithAccount:account Password:password successBlock:^(id responseData){
        [self.user loadWithDictionary:responseData];
        if ( [self.user.autoLogin boolValue] )
            self.user.password = self.passwordTextField.text;
        [User saveToCache:self.user];
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:0];
        [self dismissViewControllerAnimated:YES completion:nil];
        PersonModel * model = [[PersonModel alloc] init];
        model.user = self.user;
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWarningMessage object:LogInSuccessful];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPersonPageClicked object:model];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLeftMenuUserRefresh object:nil];
    } failureBlock:^(NSError *error, NSString * responseString) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = LogInFailure;
        [hud hide:YES afterDelay:1];
    }];
}
- (IBAction)peekClicked:(id)sender {
    self.isPasswordVisible = !self.isPasswordVisible;
}

#pragma mark - MBProgressHUDDeleagte
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

#pragma - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
