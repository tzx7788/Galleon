//
//  PDFViewController.h
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFModel.h"
#import "SuperViewController.h"

@interface PDFViewController : SuperViewController

@property (strong, nonatomic) PDFModel * model;

+ (PDFViewController *)createViewController;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
