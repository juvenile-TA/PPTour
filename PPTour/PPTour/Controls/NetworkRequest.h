//
//  NetworkRequest.h
//  GuGong
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 gokaola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoNetWorking.h"
#import "InfonetWorkingDelegate.h"

@protocol NetworkRequestDelegate <NSObject>

- (void)requestSuccessWithInfo:(id)info;
- (void)requestFailWithError:(NSError *)error;

@end

@interface NetworkRequest : NSObject

- (void)requestDataFromServerWithInfo:(NSDictionary *)requestDic;

- (id)initWithDelegate:(id<NetworkRequestDelegate>)delegate;

@end
