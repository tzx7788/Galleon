//
//  NewsListViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListModel.h"
#import "SuperViewController.h"

@interface NewsListViewController : SuperViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (NewsListViewController *)createViewController;

@end
