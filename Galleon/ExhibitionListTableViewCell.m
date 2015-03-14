//
//  ExhibitionListTableViewCell.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionListTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation ExhibitionListTableViewCell

+(ExhibitionListTableViewCell *)createCell
{
    ExhibitionListTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ExhibitionListTableViewCell" owner:self options:nil] lastObject];
    return cell;
}

- (void)setExhibitionModel:(ExhibitionModel *)exhibitionModel
{
    _exhibitionModel = exhibitionModel;
    self.exhibitionTitleLabel.text = exhibitionModel.exhibitionName;
    [self.exhibitionImageView setImageWithURL:[NSURL URLWithString:exhibitionModel.titleImageURLString]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
