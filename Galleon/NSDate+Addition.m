//
//  NSDate+Addition.m
//  Galleon
//
//  Created by Tang Zhixiong on 01/04/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)

static NSDateFormatter *formatter = nil;
+ (NSDate *)covertFromString:(NSString *)dateString
{
    if (!formatter){
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
    }
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate * date = [formatter dateFromString:dateString];
    return date;
}

- (NSString *) description
{
    if (!formatter){
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
    }
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:self];
}

@end
