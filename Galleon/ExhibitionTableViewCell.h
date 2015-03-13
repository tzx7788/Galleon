//
//  ExhibitionTableViewCell.h
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitionType.h"
#define ExhibitionTableViewCellRowHeight 122

@interface ExhibitionTableViewCell : UITableViewCell

@property (nonatomic,strong) ExhibitionType * type;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (ExhibitionTableViewCell *)createCell;

@end
