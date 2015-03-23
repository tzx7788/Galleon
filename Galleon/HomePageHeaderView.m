//
//  HomePageHeaderView.m
//  Galleon
//
//  Created by Tang Zhixiong on 21/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "HomePageHeaderView.h"
#import "NewsImageModel.h"
#import "NotificationConstant.h"
#import "NewsViewController.h"
#import "Client.h"

@interface HomePageHeaderView()<KDCycleBannerViewDataource, KDCycleBannerViewDelegate>
@property (nonatomic, strong) NSArray * modelList;

@end

@implementation HomePageHeaderView

+ (HomePageHeaderView *)createView
{
    HomePageHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"HomePageHeaderView" owner:self options:nil] lastObject];
    return view;
}

- (void)awakeFromNib
{
    [[Client sharedClient] getAllNewImageWithsuccessBlock:^(id responseData){
        NSArray * array = responseData;
        NSMutableArray * list = [[NSMutableArray alloc] init];
        for (id dict in array) {
            NewsImageModel * model = [[NewsImageModel alloc] init];
            if (dict[@"news_id"]) model.newsId = dict[@"news_id"];
            if (dict[@"link"]) model.imageURL = dict[@"link"];
            if (dict[@"visiable"]) model.visible = dict[@"visiable"];
            if (dict[@"id"]) model.imageId = dict[@"id"];
            [list addObject:model];
            self.countDownLabel.text = @"sadfasdflkfjsldkfjalsdfj;asldkfjal;skdfjlsjf;aklsdjf;aslkdfj;asdkfjals;dfjlsfjlasdfjlasdfjl";
        }
        self.modelList = [list copy];
        [self.bannerView reloadDataWithCompleteBlock:nil];
    } failureBlock:nil];
}

- (NSArray *)numberOfKDCycleBannerView:(KDCycleBannerView *)bannerView
{
    NSMutableArray * urlArray = [[NSMutableArray alloc] init];
    for ( NewsImageModel * model in self.modelList )
        [urlArray addObject:model.imageURL];
    return urlArray;
}
- (UIViewContentMode)contentModeForImageIndex:(NSUInteger)index
{
    return UIViewContentModeScaleAspectFill;
}

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didSelectedAtIndex:(NSUInteger)index
{
    NewsModel * model = [[NewsModel alloc] init];
    NewsImageModel * imageModel = self.modelList[index];
    model.newsId = imageModel.newsId;
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNewsDetailClicked object:model];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
