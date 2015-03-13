//
//  ExhibitionTableViewCell.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionTableViewCell.h"

@implementation ExhibitionTableViewCell

+ (ExhibitionTableViewCell *)createCell
{
    ExhibitionTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"ExhibitionTableViewCell" owner:self options:nil] lastObject];
    return cell;
}

- (void)setType:(ExhibitionType *)type
{
    _type = type;
    [self.backImageView setImage:type.backGroundImage];
    self.nameLabel.text = type.name;
}

- (void)awakeFromNib {
    if ( self.type ){
        [self.backImageView setImage:self.type.backGroundImage];
        self.nameLabel.text = self.type.name;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
