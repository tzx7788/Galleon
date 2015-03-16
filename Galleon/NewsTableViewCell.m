//
//  NewsTableViewCell.m
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation NewsTableViewCell

- (void)setModel:(NewsModel *)model
{
    _model = model;
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:model.avatarURLString]];
    self.titleLabel.text = model.titleString;
    self.dataLabel.text = [model.date description];
}

+ (NewsTableViewCell *)createCell
{
    NewsTableViewCell * cell;
    cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil] lastObject];
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
