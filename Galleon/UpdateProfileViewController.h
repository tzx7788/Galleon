//
//  UpdateProfileViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 24/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"
#import "RegisterViewController.h"

@interface UpdateProfileViewController : RegisterViewController

@property (nonatomic, strong) PersonModel * model;

+ (UpdateProfileViewController *)createViewController;

@end
