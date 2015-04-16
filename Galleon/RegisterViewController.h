//
//  RegisterViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 14/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@interface RegisterViewController : SuperViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *campanyTextField;
@property (weak, nonatomic) IBOutlet UITextField *jobTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (nonatomic, strong) NSString * headerName;

- (IBAction)ComfirmClicked:(id)sender;
- (BOOL)verified;

@end
