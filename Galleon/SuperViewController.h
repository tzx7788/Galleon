//
//  SuperViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 12/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewControllerDelegate.h"
#import "SuperModel.h"

@interface SuperViewController : UIViewController<SuperViewControllerDelegate>

@property (nonatomic, strong) SuperModel * model;

+ (instancetype)createViewController;

@end
