//
//  UIImage+Snapshot
//  WeCampus
//
//  Created by 吴 wuziqi on 13-9-13.
//  Copyright (c) 2013年 Ziqi Wu. All rights reserved.
//

#import "UIImage+Snapshot.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (Snapshot)

+ (UIImage *)snapshotForView:(UIView *)aView {
    CGSize pageSize = aView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(pageSize, aView.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [aView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
