//
//  Client.h
//  Galleon
//
//  Created by Tang Zhixiong on 15/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRequest.h"

@interface Client : NSObject

+ (Client *)sharedClient;

- (void)enqueueTokenRequest:(GRequest *)rawRequest;

- (void) test;

@end
