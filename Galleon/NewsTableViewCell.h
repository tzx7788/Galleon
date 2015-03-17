//
//  NewsTableViewCell.h
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

#define NewsTableViewCellHeight 60.0f

@interface NewsTableViewCell : UITableViewCell

@property (strong, nonatomic) NewsModel * model;


@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@property (weak, nonatomic) IBOutlet UIImageView *enImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cnImageView;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

+ (NewsTableViewCell *)createCell;

@end