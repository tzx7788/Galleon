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

+ (PersonViewController *)createViewController;

@end
