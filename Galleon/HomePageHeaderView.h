//
//  HomePageHeaderView.h
//  Galleon
//
//  Created by Tang Zhixiong on 21/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KDCycleBannerView/KDCycleBannerView.h>

@interface HomePageHeaderView : UIView
@property (weak, nonatomic) IBOutlet KDCycleBannerView *bannerView;

@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
+ (HomePageHeaderView *) createView;

@end
