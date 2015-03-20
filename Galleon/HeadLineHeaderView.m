//
//  HeadLineHeaderView.m
//  Galleon
//
//  Created by Tang Zhixiong on 20/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "HeadLineHeaderView.h"
#import "NotificationConstant.h"
#import "NewsListModel.h"

@implementation HeadLineHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)moreClicked:(id)sender {
    NewsListModel * model = [[NewsListModel alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNewsPush object:model];
}

@end
