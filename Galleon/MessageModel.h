//
//  MessageModel.h
//  Galleon
//
//  Created by Tang Zhixiong on 18/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,strong) NSString * avatarURLString;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSDate * date;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * company;

- (void)loadDataWithDictionary:(NSDictionary *)dict;

@end
