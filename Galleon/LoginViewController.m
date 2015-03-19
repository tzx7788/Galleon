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

@interface LoginViewController ()
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
    [self refreshAutoLoginButton:user.autoLogin];
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
    [[Client sharedClient] loginWithAccount:self.accountTextField.text Password:self.passwordTextField.text successBlock:^(id responseData){
        if ( responseData[@"account"] != [NSNull null] )
            self.user.account = responseData[@"account"];
        if ( responseData[@"company"] != [NSNull null] )
            self.user.company = responseData[@"company"];
        if ( responseData[@"description"] != [NSNull null] )
            self.user.descript = responseData[@"description"];
        if ( responseData[@"email"] != [NSNull null] )
            self.user.email = responseData[@"email"];
        if ( responseData[@"header_small"] != [NSNull null] )
            self.user.iconImageURLString = responseData[@"header_small"];
        if ( responseData[@"id"] != [NSNull null] )
            self.user.userId = responseData[@"id"];
        if ( responseData[@"is_active"] != [NSNull null] )
            self.user.isActive = responseData[@"is_active"];
        if ( responseData[@"is_vip"] != [NSNull null] )
            self.user.isVIP = responseData[@"is_vip"];
        if ( responseData[@"lastlogin_time"] != [NSNull null] )
            self.user.lastLogInTime = responseData[@"lastlogin_time"];
        if ( responseData[@"myattr"] != [NSNull null] )
            self.user.myattr = responseData[@"myattr"];
        if ( responseData[@"name"] != [NSNull null] )
            self.user.name = responseData[@"name"];
        if ( responseData[@"nickname"] != [NSNull null] )
            self.user.nickName = responseData[@"nickname"];
        if ( responseData[@"password"] != [NSNull null] )
            self.user.password = responseData[@"password"];
        if ( responseData[@"phone_number"] != [NSNull null] )
            self.user.phone = responseData[@"phone_number"];
        if ( responseData[@"registered_time"] != [NSNull null] )
            self.user.registeredTime = responseData[@"registered_time"];
        if ( responseData[@"role"] != [NSNull null] )
            self.user.role = responseData[@"role"];
        if ( responseData[@"token"] != [NSNull null] )
            self.user.token = responseData[@"token"];
        [User saveToCache:self.user];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failureBlock:^(NSError *error, NSString * responseString) {
        
    }];
}

- (IBAction)peekClicked:(id)sender {
    self.isPasswordVisible = !self.isPasswordVisible;
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
