//
//  SuperViewControllerDelegate.h
//  Galleon
//
//  Created by Tang Zhixiong on 16/04/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuperModel.h"

@protocol SuperViewControllerDelegate <NSObject>

@required
+(UIViewController *) createViewController;

@optional
@property (nonatomic, strong) SuperModel * model;

@end
