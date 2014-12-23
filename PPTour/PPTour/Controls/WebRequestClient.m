//
//  WebRequestClient.m
//  GuGong
//
//  Created by apple on 14-5-12.
//  Copyright (c) 2014年 gokaola. All rights reserved.
//

#import "WebRequestClient.h"

#define BASE_URL @"http://115.28.37.180/itfc/mobile/HTTPService.action"

static WebRequestClient *instance = nil;

@implementation WebRequestClient

+ (WebRequestClient *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WebRequestClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    return instance;
}

@end
