//
//  LoginViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 14/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

@interface LoginViewController ()
@property (nonatomic, strong) User * user;
@end

@implementation LoginViewController

- (void) setUser:(User *)user
{
    _user = user;
    [self refreshAutoLoginButton:user.autoLogin];
}

- (void)refreshAutoLoginButton:(BOOL)isSelected
{
    if ( isSelected ) {
        [self.autoLoginButton setBackgroundImage:[UIImage imageNamed:@"ic_checked_normal.png"] forState:UIControlStateNormal];
        [self.autoLoginButton setBackgroundImage:[UIImage imageNamed:@"ic_checked_pressed.png"] forState:UIControlStateHighlighted];
    } else {
        [self.autoLoginButton setBackgroundImage:[UIImage imageNamed:@"ic_unchecked_normal.png"] forState:UIControlStateNormal];
        [self.autoLoginButton setBackgroundImage:[UIImage imageNamed:@"ic_unchecked_press.png"] forState:UIControlStateHighlighted];
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
    [self refreshAutoLoginButton:isAutoLogin];
}

- (IBAction)LoginClicked:(id)sender {
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
