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
#import <PBJVideoPlayerController.h>
#import <AVFoundation/AVFoundation.h>

@interface NewsViewController ()<PBJVideoPlayerControllerDelegate>

@property (nonatomic, strong) UIButton * playButton;

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

- (void)viewDidLayoutSubviews
{
    if ( !self.playButton ){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.webView.scrollView addSubview:btn];
        self.playButton = btn;
        CGFloat width = self.webView.scrollView.frame.size.width;
        [self.playButton setFrame:CGRectMake(0, -width * 0.5f, width, width * 0.5f)];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"btn_play_video"] forState:UIControlStateNormal];
        [self.playButton addTarget:self action:@selector(playClicked) forControlEvents:UIControlEventTouchUpInside];
        [self setHasVideo:self.model.hasVideo];
    }
}

- (void)playClicked
{
    if ( self.model.hasVideo ) {
        NSLog(@"%@",self.model.videoURLString);
//        AVPlayer * player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://aero.wisdomriver.com.cn/_uploads/files/24934980.mp4"]];
//        AVPlayerLayer *layer=[AVPlayerLayer playerLayerWithPlayer:player];
//        layer.backgroundColor=[[UIColor redColor]CGColor];
//        
//        [self.view.layer addSublayer:layer];
//        [player play];
        // allocate controller
        MPMoviePlayerViewController *movie = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://122.10.73.219:5001/"]];
        
        [movie.moviePlayer prepareToPlay];
        [self presentMoviePlayerViewControllerAnimated:movie];
        [movie.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
        
        [movie.view setBackgroundColor:[UIColor clearColor]];
        
        [movie.view setFrame:self.view.bounds];
        [[NSNotificationCenter defaultCenter]addObserver:self
         
                                               selector:@selector(movieFinishedCallback:)
         
                                                   name:MPMoviePlayerPlaybackDidFinishNotification
         
                                                 object:movie.moviePlayer];
    }
}

- (void)videoPlayerReady:(PBJVideoPlayerController *)videoPlayer
{
}
- (void)videoPlayerPlaybackStateDidChange:(PBJVideoPlayerController *)videoPlayer
{
}

- (void)videoPlayerPlaybackWillStartFromBeginning:(PBJVideoPlayerController *)videoPlayer
{
}
- (void)videoPlayerPlaybackDidEnd:(PBJVideoPlayerController *)videoPlayer
{
}

-(void)movieFinishedCallback:(NSNotification*)notify{
    MPMoviePlayerController* theMovie = [notify object];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self
     
                                                  name:MPMoviePlayerPlaybackDidFinishNotification
     
                                                object:theMovie];
    
    [self dismissMoviePlayerViewControllerAnimated];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.viewCountLabel.text = [self.model.viewCount description];
    self.thumbCountLabel.text = [self.model.thumbCount description];
    [self.webView loadHTMLString:self.model.content baseURL:nil];
}

- (void) setHasVideo:(BOOL)hasVideo
{
    if ( hasVideo ){
        CGFloat width = self.webView.scrollView.frame.size.width;
        [self.playButton setHidden:NO];
        [self.webView.scrollView setContentInset:UIEdgeInsetsMake(width * 0.5f, 0, 0, 0)];
    } else {
        [self.playButton setHidden:YES];
        [self.webView.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (void)loadData
{
    [[Client sharedClient] getNewsDetialWithId:self.model.newsId successBlock:^(id responseData){
        [self.model loadDataWithDictionary:responseData];
        self.viewCountLabel.text = [self.model.viewCount description];
        self.thumbCountLabel.text = [self.model.thumbCount description];
        [self.webView loadHTMLString:self.model.content baseURL:nil];
        [self setHasVideo:self.model.hasVideo];
    } failureBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)thumberClicked:(id)sender {
    
    static BOOL isAvailable = YES;
    
    if ( isAvailable ) {
        int count = [self.model.thumbCount intValue];
        count++;
        self.model.thumbCount = [NSNumber numberWithInt:count];
        self.thumbCountLabel.text = [self.model.thumbCount description];
        isAvailable = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            isAvailable = YES;
        });
    }
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
