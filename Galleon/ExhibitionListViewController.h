//
//  ExhibitionListViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitionListModel.h"

@interface ExhibitionListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (ExhibitionListViewController *) createViewController;

@end
