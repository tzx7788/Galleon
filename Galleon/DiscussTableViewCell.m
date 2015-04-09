//
//  DiscussTableViewCell.m
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "DiscussTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation DiscussTableViewCell

- (void) setModel:(MessageModel *)model
{
    _model = model;
    [self.avatarImage setImageWithURL:[NSURL URLWithString:model.avatarURLString]];
    self.nameLabel.text = model.name;
    self.dateLabel.text = model.date.description;
    self.contentLabel.text = model.content;
    self.companyLabel.text = model.company;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
