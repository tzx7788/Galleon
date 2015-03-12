//
//  UIBarButtonItem+Addition.h
//  WeCampus
//
//  Created by 吴 wuziqi on 13-8-12.
//  Copyright (c) 2013年 Ziqi Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Resize)

- (void)resetOriginX:(CGFloat)originX;

- (void)resetOriginY:(CGFloat)originY;

- (void)resetWidth:(CGFloat)width;

- (void)resetHeight:(CGFloat)height;

- (void)resetOrigin:(CGPoint)origin;

- (void)resetSize:(CGSize)size;

- (void)resetFrameWithOrigin:(CGPoint)origin size:(CGSize)size;

- (void)adjustHalfPixel;

- (void)resetHeightByOffset:(CGFloat)offset;

- (void)resetWidthByOffset:(CGFloat)offset;

- (void)resetOriginYByOffset:(CGFloat)offset;

- (void)resetOriginXByOffset:(CGFloat)offset;

- (void)resetCenterY:(CGFloat)centerY;

- (void)resetCenterX:(CGFloat)centerX;

- (CGFloat)getBottomY;
- (CGFloat)getRightX;

- (CGFloat)getHeight;
- (CGFloat)getWidth;

@end
