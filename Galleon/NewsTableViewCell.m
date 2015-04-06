//
//  NewsTableViewCell.m
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "ImageConstant.h"

@interface NewsTableViewCell()
@property (nonatomic, strong) NSArray * imageViewList;
@end

@implementation NewsTableViewCell

- (void)setModel:(NewsModel *)model
{
    _model = model;
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:model.avatarURLString]];
    self.titleLabel.text = model.titleString;
    self.dataLabel.text = [model.date description];
    int index = 0;
    if (model.hasVideo) {
        [(UIImageView *)self.imageViewList[index] setImage:VideoImage];
        [(UIImageView *)self.imageViewList[index++] setHidden:NO];
    }
    
    if (model.isEN) {
        [(UIImageView *)self.imageViewList[index] setImage:EnImage];
        [(UIImageView *)self.imageViewList[index++] setHidden:NO];
    }
    if (model.isCN) {
        [(UIImageView *)self.imageViewList[index] setImage:CnImage];
        [(UIImageView *)self.imageViewList[index++] setHidden:NO];
    }
    while ( index < self.imageViewList.count ) {
        [(UIImageView *)self.imageViewList[index++] setHidden:YES];
    }
}

+ (NewsTableViewCell *)createCell
{
    NewsTableViewCell * cell;
    cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil] lastObject];
    return cell;
}

- (void)awakeFromNib {
    if ( !self.imageViewList ){
        self.imageViewList = [NSArray arrayWithObjects:self.firstImageVIew, self.secondImageView, self.thirdImageView,nil];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
