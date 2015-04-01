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
#import "StringConstant.h"
#import "Client.h"
#import "ExhibitionModel.h"

@interface HomePageHeaderView()<KDCycleBannerViewDataource, KDCycleBannerViewDelegate>
@property (nonatomic, strong) ExhibitionModel * countDownExhibition;
@property (nonatomic, strong) NSArray * modelList;

@end

@implementation HomePageHeaderView

+ (HomePageHeaderView *)createView
{
    HomePageHeaderView * view = [[[NSBundle mainBundle] loadNibNamed:@"HomePageHeaderView" owner:self options:nil] firstObject];
    return view;
}

- (void)awakeFromNib
{
    [self.bannerView setAutoPlayTimeInterval:5.0f];
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
        }
        self.modelList = [list copy];
        [self.bannerView reloadDataWithCompleteBlock:nil];
    } failureBlock:nil];
    [[Client sharedClient] getSystemTimeWithsuccessBlock:^(id timeDict){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.S"];
        NSDate * systemDate = [formatter dateFromString:timeDict[@"system_time"]];
        [[Client sharedClient] getCountDownExhibitionWithsuccessBlock:^(id responseData){
            self.countDownExhibition = [[ExhibitionModel alloc] init];
            [self.countDownExhibition loadWithDictionary:responseData];
            NSTimeInterval interval =[self.countDownExhibition.startedTime timeIntervalSinceDate:systemDate];
            int dayInterval = interval / (60 * 60 * 24);
            self.countDownLabel.text = [NSString stringWithFormat:@"%@\n%@ %d %@", self.countDownExhibition.exhibitionName,In,dayInterval,Days];
            //[[NSNotificationCenter defaultCenter] postNotificationName:NotificationExhibitionAddToCalendar object:self.countDownExhibition];
        } failureBlock:^(NSError *error, NSString * responseString) {
            
        }];
    } failureBlock:nil];
}

- (IBAction)exhibitionClicked:(id)sender {
    if (self.countDownExhibition)
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationExhibitionAddToCalendar object:self.countDownExhibition];
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
