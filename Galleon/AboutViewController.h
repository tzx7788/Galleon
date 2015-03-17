//
//  AboutViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutModel.h"

@interface AboutViewController : UIViewController

@property (nonatomic, strong) AboutModel * model;

+ (AboutViewController *)createViewController;

@end
