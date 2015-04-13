//
//  NewsViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "NewsModel.h"

@interface NewsViewController : SuperViewController

@property (nonatomic) NewsModel * model;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

+ (NewsViewController *)createViewController;
@property (weak, nonatomic) IBOutlet UILabel *thumbCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;

@end
