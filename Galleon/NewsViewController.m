//
//  NewsViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "NewsViewController.h"
#import "Client.h"
#import <MediaPlayer/MediaPlayer.h>

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
        if ( self.model.hasVideo ) {
            MPMoviePlayerController * vc = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:responseData[@"video_link"] ]];
            vc.controlStyle = MPMovieControlStyleNone;
            vc.shouldAutoplay = YES;
            vc.repeatMode = MPMovieRepeatModeOne;
            [vc setFullscreen:YES animated:YES];
            vc.scalingMode = MPMovieScalingModeAspectFit;
            [vc play];
            [self.view addSubview:vc.view];
        }
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
