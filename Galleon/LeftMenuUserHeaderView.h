//
//  LeftMenuUserHeaderView.h
//  Galleon
//
//  Created by Tang Zhixiong on 14/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LeftMenuUserHeaderViewHeight 100

@interface LeftMenuUserHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;

+ (LeftMenuUserHeaderView *)createView;

@end
