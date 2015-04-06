//
//  NewsTableViewCell.h
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsTableViewCell : UITableViewCell

@property (strong, nonatomic) NewsModel * model;


@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;


@property (weak, nonatomic) IBOutlet UIImageView *firstImageVIew;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

+ (NewsTableViewCell *)createCell;

@end
