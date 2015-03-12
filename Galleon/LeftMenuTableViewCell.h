//
//  LeftMenuTableViewCell.h
//  Galleon
//
//  Created by Tang Zhixiong on 11/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    LeftMenuTableViewCellHomePage = 0,
    LeftMenuTableViewCellInformation,
    LeftMenuTableViewCellExhibition,
    LeftMenuTableViewCellDiscuss,
    LeftMenuTableViewCellAbout,
} LeftMenuTableViewCellType;

@interface LeftMenuTableViewCell : UITableViewCell

@property (assign, nonatomic) LeftMenuTableViewCellType type;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end
