//
//  InformModel.h
//  Galleon
//
//  Created by Tang Zhixiong on 22/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformModel : NSObject

@property (nonatomic, strong) NSString * informId;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSDate * createdTime;

- (void)loadWithDictionary:(NSDictionary *)dict;

@end
