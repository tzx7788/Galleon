//
//  ExhibitionListTableViewCell.h
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitionModel.h"

#define ExhibitionListTableViewCellHeight 60.0f

@interface ExhibitionListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *exhibitionImageView;
@property (weak, nonatomic) IBOutlet UILabel *exhibitionTitleLabel;
@property (weak, nonatomic) ExhibitionModel * exhibitionModel;

+ (ExhibitionListTableViewCell *)createCell;

@end
