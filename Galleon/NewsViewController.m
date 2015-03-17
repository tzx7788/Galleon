//
//  NewsViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "NewsViewController.h"
#import "Client.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

+ (NewsViewController *)createViewController
{
    NewsViewController * vc = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData
{
    [[Client sharedClient] getNewsDetialWithId:self.model.newsId successBlock:^(id responseData){
        [self.webView loadHTMLString:responseData[@"content"] baseURL:nil];
    } failureBlock:nil];
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
