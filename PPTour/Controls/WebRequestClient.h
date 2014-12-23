//
//  WebRequestClient.h
//  GuGong
//
//  Created by apple on 14-5-12.
//  Copyright (c) 2014年 gokaola. All rights reserved.
//

#import "AFHTTPClient.h"

@interface WebRequestClient : AFHTTPClient

+ (WebRequestClient *)sharedInstance;

@end
