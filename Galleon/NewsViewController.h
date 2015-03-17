//
//  NewsViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsViewController : UIViewController

@property (nonatomic, strong) NewsModel * model;

+ (NewsViewController *)createViewController;

@end
