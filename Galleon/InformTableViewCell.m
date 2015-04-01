//
//  InformTableViewCell.m
//  Galleon
//
//  Created by Tang Zhixiong on 22/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "InformTableViewCell.h"
#import "NSDate+Addition.h"

@implementation InformTableViewCell

- (void)setModel:(InformModel *)model
{
    _model = model;
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = [model.createdTime description];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
