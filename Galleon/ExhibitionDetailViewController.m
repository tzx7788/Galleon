//
//  ExhibitionDetailViewController.m
//  Galleon
//
//  Created by Tang Zhixiong on 23/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionDetailViewController.h"

@interface ExhibitionDetailViewController ()<UIWebViewDelegate>

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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString * string = [NSString stringWithFormat:@"var script = document.createElement('script');"
                         "script.type = 'text/javascript';"
                         "script.text = \"function ResizeImages() { "
                         "var myimg,oldwidth;"
                         "var maxwidth = %f;" // UIWebView中显示的图片宽度
                         "for(i=0;i <document.images.length;i++){"
                         "myimg = document.images[i];"
                         "if(myimg.width > maxwidth){"
                         "oldwidth = myimg.width;"
                         "myimg.width = maxwidth;"
                         "}"
                         "}"
                         "}\";"
                         "document.getElementsByTagName('head')[0].appendChild(script);", webView.frame.size.width - 20];
    [webView stringByEvaluatingJavaScriptFromString:string];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
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
