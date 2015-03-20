//
//  SelectionViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 20/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectionViewController : UIViewController

@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) NSArray * dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
