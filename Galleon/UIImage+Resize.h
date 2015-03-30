//
//  UIImage+Resize.h
//  Galleon
//
//  Created by Tang Zhixiong on 28/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)
- (UIImage*)cutImageWithRadius:(int)radius;
-(UIImage*)  OriginImage:(UIImage *)image   scaleToSize:(CGSize)size;
-(UIImage*)  OriginImage:(UIImage *)image   scale:(CGFloat)scale;
@end
