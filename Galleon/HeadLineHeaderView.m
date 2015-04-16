//
//  HeadLineHeaderView.m
//  Galleon
//
//  Created by Tang Zhixiong on 20/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "HeadLineHeaderView.h"
#import "NotificationConstant.h"
#import "StringConstant.h"
#import "NewsListModel.h"
#import "NewsListPushNotification.h"

@implementation HeadLineHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)moreClicked:(id)sender {
    NewsListPushNotification * pushNotification = [[NewsListPushNotification alloc] init];
    pushNotification.title = News;
    pushNotification.model = [[NewsListModel alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPush object:pushNotification];
}

@end
