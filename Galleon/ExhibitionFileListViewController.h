//
//  ExhibitionFileListViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 23/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitionFileListModel.h"

@interface ExhibitionFileListViewController : UIViewController

@property (nonatomic, strong) ExhibitionFileListModel * model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (ExhibitionFileListViewController *)createViewController;

@end
