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
#import "User.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface LeftMenuUserHeaderView()

@property (nonatomic, strong) User *user;

@end

@implementation LeftMenuUserHeaderView

+ (LeftMenuUserHeaderView *)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LeftMenuUserHeaderView" owner:self options:nil] lastObject];
}

- (void)awakeFromNib
{
    [self reloadUser];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:NotificationLeftMenuUserRefresh object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationLeftMenuUserRefresh object:nil];
}

- (void)reloadUser
{
    self.user = [User awakeFromCache];
    [self.headerImageView setImageWithURL:[NSURL URLWithString:self.user.iconImageURLString] placeholderImage:nil];
    self.nameLabel.text = self.user.name;
    self.identityLabel.text = self.user.role;
}

- (void)refresh
{
    [self reloadUser];
}

- (IBAction)clicked:(id)sender {
    PersonModel * model = [[PersonModel alloc] init];
    model.user = self.user;
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
