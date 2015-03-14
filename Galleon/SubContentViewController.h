//
//  SubContentViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 12/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "SuperViewController.h"
#import "TitleLabel.h"

@interface SubContentViewController : SuperViewController

@property (nonatomic, strong) UIViewController * contentViewController;
@property (nonatomic, strong) TitleLabel * titleLabel;

+ (SubContentViewController *) createViewController;

@end
