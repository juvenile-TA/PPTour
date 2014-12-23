//
//  InfonetWorkingDelegate.h
//  
//
//  Created by wuxiang on 13-8-23.
//  Copyright (c) 2013年 wuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InfonetWorkingDelegate<NSObject>

- (void)callFinish:(id )caller withData:(NSData *)data;

@optional

- (void)callFailed:(id )caller withError:(NSError *)error;

- (void)callIsConnect:(BOOL)connect;
@end

