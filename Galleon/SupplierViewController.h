//
//  SupplierViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 31/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupplierModel.h"

@interface SupplierViewController : UIViewController
@property (nonatomic, strong) SupplierModel * model;

+ (SupplierViewController *)createViewController;

@end
