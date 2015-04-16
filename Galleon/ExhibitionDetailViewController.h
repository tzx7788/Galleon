//
//  ExhibitionDetailViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 23/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "ExhibitionDetailModel.h"

@interface ExhibitionDetailViewController : SuperViewController

@property (nonatomic, strong) ExhibitionDetailModel * model;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

+ (ExhibitionDetailViewController *) createViewController;

@end
