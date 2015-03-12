//
//  LeftMenuTableViewCell.m
//  Galleon
//
//  Created by Tang Zhixiong on 11/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "LeftMenuTableViewCell.h"
#import "StringConstant.h"
#import "ImageConstant.h"

@implementation LeftMenuTableViewCell

- (void)setType:(LeftMenuTableViewCellType)type
{
    _type = type;
    switch (type) {
        case LeftMenuTableViewCellHomePage:
            self.iconImageView.image = HomePageIcon;
            self.contentLabel.text = HomePage;
            break;
        case LeftMenuTableViewCellNews:
            self.iconImageView.image = NewsIcon;
            self.contentLabel.text = News;
            break;
        case LeftMenuTableViewCellExhibition:
            self.iconImageView.image = ExhibitionIcon;
            self.contentLabel.text = Exhibition;
            break;
        case LeftMenuTableViewCellDiscuss:
            self.iconImageView.image = DiscussIcon;
            self.contentLabel.text = Discuss;
            break;
        case LeftMenuTableViewCellAbout:
            self.iconImageView.image = AboutUsIcon;
            self.contentLabel.text = AboutUs;
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
