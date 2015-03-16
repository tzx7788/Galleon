//
//  NewsModel.h
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, strong) NSString * avatarURLString;
@property (nonatomic, strong) NSString * titleString;
@property (nonatomic, strong) NSDate * date;
@property (assign) BOOL isCN;
@property (assign) BOOL isEN;
@property (assign) BOOL hasVideo;

@end
