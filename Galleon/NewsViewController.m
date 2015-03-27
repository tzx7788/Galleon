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

- (void)viewWillAppear:(BOOL)animated
{
    self.viewCountLabel.text = [self.model.viewCount description];
    self.thumbCountLabel.text = [self.model.thumbCount description];
    [self.webView loadHTMLString:self.model.content baseURL:nil];
}

- (void)embedWithVideoLink:(NSString *) videoLink
{
    NSString *urlStr = videoLink;
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString * videoLinkString = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        self.model.content = [NSString stringWithFormat:@"%@%@",videoLinkString,self.model.content];
        [self.webView loadHTMLString:self.model.content baseURL:nil];
    }];
}

- (void)loadData
{
    [[Client sharedClient] getNewsDetialWithId:self.model.newsId successBlock:^(id responseData){
        [self.model loadDataWithDictionary:responseData];
        self.viewCountLabel.text = [self.model.viewCount description];
        self.thumbCountLabel.text = [self.model.thumbCount description];
        [self.webView loadHTMLString:self.model.content baseURL:nil];
        if ( self.model.hasVideo ) {
            NSURL * url = [NSURL URLWithString:self.model.videoURLString];
            self.model.videoURLString = [NSString stringWithFormat:@"http://aero.wisdomriver.com.cn/news/send_video/%@",[url lastPathComponent]];
            [self embedWithVideoLink:self.model.videoURLString];
        }
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
