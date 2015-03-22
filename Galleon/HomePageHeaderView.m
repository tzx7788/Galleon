//
//  HomePageHeaderView.m
//  Galleon
//
//  Created by Tang Zhixiong on 21/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "HomePageHeaderView.h"

@interface HomePageHeaderView()<KDCycleBannerViewDataource, KDCycleBannerViewDelegate>

@end

@implementation HomePageHeaderView

- (NSArray *)numberOfKDCycleBannerView:(KDCycleBannerView *)bannerView
{
    return nil;
}
- (UIViewContentMode)contentModeForImageIndex:(NSUInteger)index
{
    return UIViewContentModeScaleAspectFill;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
