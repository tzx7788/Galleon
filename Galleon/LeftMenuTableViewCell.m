//
//  LeftMenuTableViewCell.m
//  Galleon
//
//  Created by Tang Zhixiong on 11/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "LeftMenuTableViewCell.h"

@implementation LeftMenuTableViewCell

- (void)setType:(LeftMenuTableViewCellType)type
{
    _type = type;
    switch (type) {
        case LeftMenuTableViewCellHomePage:
            self.iconImageView.image = [UIImage imageNamed:@""];
            self.contentLabel.text = NSLocalizedString(@"HomePage", @"");
            break;
        case LeftMenuTableViewCellInformation:
            self.iconImageView.image = [UIImage imageNamed:@""];
            self.contentLabel.text = @"";
            break;
        case LeftMenuTableViewCellExhibition:
            self.iconImageView.image = [UIImage imageNamed:@""];
            self.contentLabel.text = @"";
            break;
        case LeftMenuTableViewCellDiscuss:
            self.iconImageView.image = [UIImage imageNamed:@""];
            self.contentLabel.text = @"";
            break;
        case LeftMenuTableViewCellAbout:
            self.iconImageView.image = [UIImage imageNamed:@""];
            self.contentLabel.text = @"";
            break;
        default:
            break;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
