//
//  ExhibitionDetailViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 23/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionDetailViewController.h"

@interface ExhibitionDetailViewController ()

@end

@implementation ExhibitionDetailViewController

- (void) setModel:(ExhibitionDetailModel *)model
{
    _model = model;
    [self.webView loadHTMLString:model.content baseURL:nil];
}

+ (ExhibitionDetailViewController *)createViewController
{
    ExhibitionDetailViewController * vc = [[ExhibitionDetailViewController alloc] initWithNibName:@"ExhibitionDetailViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadHTMLString:self.model.content baseURL:nil];
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
