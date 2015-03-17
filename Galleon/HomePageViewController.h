//
//  HomePageViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"

@interface HomePageViewController : UIViewController

@property (nonatomic, strong) HomePageModel * model;

+ (HomePageViewController *)createViewController;

@end
