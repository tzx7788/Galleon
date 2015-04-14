//
//  PDFPushNotification.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/04/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "PDFPushNotification.h"
#import "PDFViewController.h"

@implementation PDFPushNotification

- (instancetype)init
{
    self = [super init];
    if ( self )
    {
        self.nibName = NSStringFromClass(PDFViewController.class);
    }
    return self;
}

- (NSString *)viewControllerClassName
{
    return NSStringFromClass(PDFViewController.class);
}

@end
