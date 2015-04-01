//
//  NewsModel.m
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "NewsModel.h"
#import "NSDate+Addition.h"

@implementation NewsModel

- (void)loadDataWithDictionary:(NSDictionary *)dict
{
    id object = dict;
    if (object[@"news_language"]) {
        NSString * string = [object[@"news_language"] description];
        if ([[string lowercaseString] containsString:@"zh"] )
            self.isCN = YES;
        if ([[string lowercaseString] containsString:@"en"] )
            self.isEN = YES;
    }
    if (object[@"id"]) self.newsId = object[@"id"];
    if (object[@"title"]) self.titleString = object[@"title"];
    if (object[@"icon"]) self.avatarURLString = object[@"icon"];
    if (object[@"create_time"]) self.date = [NSDate covertFromString: object[@"create_time"]];
    if (object[@"has_video"]) self.hasVideo = [object[@"has_video"] boolValue];
    if (object[@"video_link"]) self.videoURLString = object[@"video_link"];
    if (object[@"content"]) self.content = object[@"content"];
    if (object[@"awesome_count"]) self.thumbCount = object[@"awesome_count"];
    if (object[@"view_count"]) self.viewCount = object[@"view_count"];
}

@end
