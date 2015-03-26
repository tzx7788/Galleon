//
//  ExhibitionModel.h
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExhibitionModel : NSObject

@property (nonatomic, strong) NSString * exhibitionName;

@property (nonatomic, strong) NSString * titleImageURLString;

@property (nonatomic, strong) NSDate * startedTime;

@property (nonatomic, strong) NSNumber * viewCount;

@property (nonatomic, strong) NSDate * updatedTime;

@property (nonatomic, strong) NSDate * createdTime;

@property (nonatomic, strong) NSString * exhibitionId;

@property (nonatomic, strong) NSString * introContent;

@property (nonatomic, strong) NSString * serviceContent;

@property (nonatomic, strong) NSString * hostContent;

@property (nonatomic, strong) NSString * scheduleContent;

@property (nonatomic, strong) NSString * layoutContent;

- (void)loadWithDictionary:(NSDictionary *)dict;

@end
