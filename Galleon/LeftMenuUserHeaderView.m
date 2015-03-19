//
//  LeftMenuUserHeaderView.m
//  Galleon
//
//  Created by Tang Zhixiong on 14/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "LeftMenuUserHeaderView.h"
#import "PersonModel.h"
#import "NotificationConstant.h"

@implementation LeftMenuUserHeaderView

+ (LeftMenuUserHeaderView *)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LeftMenuUserHeaderView" owner:self options:nil] lastObject];
}

- (IBAction)clicked:(id)sender {
    PersonModel * model = [[PersonModel alloc] init];
    model.user = [User awakeFromCache];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPersonPageClicked object:model];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationShowContent object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
