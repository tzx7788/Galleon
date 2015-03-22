//
//  InformTableViewCell.h
//  Galleon
//
//  Created by Tang Zhixiong on 22/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformModel.h"

@interface InformTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (nonatomic, strong) InformModel *model;

@end
