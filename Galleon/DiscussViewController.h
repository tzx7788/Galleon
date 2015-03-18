//
//  DiscussViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscussModel.h"

@interface DiscussViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DiscussModel * model;

+ (DiscussViewController *)createViewController;

@end
