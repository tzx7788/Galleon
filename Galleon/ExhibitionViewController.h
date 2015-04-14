//
//  ExhibitionViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "ExhibitionModel.h"

@interface ExhibitionViewController : SuperViewController

@property (nonatomic, strong) ExhibitionModel * model;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (ExhibitionViewController *)createViewController;
@end
