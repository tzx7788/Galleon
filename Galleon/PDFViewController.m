//
//  PDFViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "PDFViewController.h"

@interface PDFViewController ()

@end

@implementation PDFViewController

+ (PDFViewController *)createViewController
{
    PDFViewController * vc = [[PDFViewController alloc] initWithNibName:@"PDFViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scalesPageToFit = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ( self.model ) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.pdfURLString]]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
