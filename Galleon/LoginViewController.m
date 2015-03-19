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
@end

@implementation LoginViewController

- (void) setUser:(User *)user
{
    _user = user;
    self.accountTextField.text = user.account;
    self.passwordTextField.text = user.password;
    [self refreshAutoLoginButton:user.autoLogin];
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
        self.user.account = responseData[@"account"];
        if ( responseData[@"company"] != [NSNull null] )
            self.user.company = responseData[@"company"];
        self.user.descript = responseData[@"description"];
        self.user.email = responseData[@"email"];
        self.user.iconImageURLString = responseData[@"header_small"];
        self.user.userId = responseData[@"id"];
        self.user.isActive = responseData[@"is_active"];
        self.user.isVIP = responseData[@"is_vip"];
        self.user.lastLogInTime = responseData[@"lastlogin_time"];
        self.user.myattr = responseData[@"myattr"];
        self.user.name = responseData[@"name"];
        self.user.nickName = responseData[@"nickname"];
        self.user.password = responseData[@"password"];
        self.user.phone = responseData[@"phone_number"];
        self.user.registeredTime = responseData[@"registered_time"];
        self.user.role = responseData[@"role"];
        self.user.token = responseData[@"token"];
        [User saveToCache:self.user];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failureBlock:^(NSError *error, NSString * responseString) {
        
    }];
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
