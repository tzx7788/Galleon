//
//  JetlinerViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 31/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JetlinerModel.h"

@interface JetlinerViewController : UIViewController

@property (nonatomic, strong) JetlinerModel * model;

+ (JetlinerViewController *)createViewController;

@end
