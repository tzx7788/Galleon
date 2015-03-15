//
//  UIAlertView+ErrorMessage.m
//  WeCampus
//
//  Created by satanwoo on 13-11-12.
//  Copyright (c) 2013年 Ziqi Wu. All rights reserved.
//

#import "UIAlertView+ErrorMessage.h"

@implementation UIAlertView (ErrorMessage)

+ (void)alertErrorMessage:(NSString *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
    
    [alertView show];
}

@end
