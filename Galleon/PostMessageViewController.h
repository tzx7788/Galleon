//
//  PostMessageViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "PostMessageModel.h"

@interface PostMessageViewController : SuperViewController

@property (nonatomic, strong) PostMessageModel * model;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
+ (PostMessageViewController *)createViewController;

@end
