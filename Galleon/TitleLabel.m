//
//  TitleLabel.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "TitleLabel.h"

@implementation TitleLabel

+ (TitleLabel *)createLabel
{
    TitleLabel * label = [[[NSBundle mainBundle] loadNibNamed:@"TitleLabel" owner:self options:nil]lastObject];
    return label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
