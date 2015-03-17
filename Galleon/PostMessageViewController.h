//
//  PostMessageViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostMessageModel.h"

@interface PostMessageViewController : UIViewController

@property (nonatomic, strong) PostMessageModel * model;

+ (PostMessageViewController *)createViewController;

@end
