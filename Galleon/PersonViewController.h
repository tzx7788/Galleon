//
//  PersonViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

@interface PersonViewController : UIViewController

@property (nonatomic, strong) PersonModel * model;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
+ (PersonViewController *)createViewController;

@end
