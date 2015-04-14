//
//  ExhibitionPushNotification.m
//  Galleon
//
//  Created by Tang Zhixiong on 14/04/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionPushNotification.h"
#import "ExhibitionViewController.h"

@implementation ExhibitionPushNotification

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        self.nibName = NSStringFromClass(ExhibitionViewController.class);
    }
    return self;
}

- (NSString *) viewControllerClassName
{
    return NSStringFromClass(ExhibitionViewController.class);
}
@end
