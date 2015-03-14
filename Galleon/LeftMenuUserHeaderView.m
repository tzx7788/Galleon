//
//  LeftMenuUserHeaderView.m
//  Galleon
//
//  Created by Tang Zhixiong on 14/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "LeftMenuUserHeaderView.h"

@implementation LeftMenuUserHeaderView

+ (LeftMenuUserHeaderView *)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LeftMenuUserHeaderView" owner:self options:nil] lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
