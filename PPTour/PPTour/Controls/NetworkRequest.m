//
//  NetworkRequest.m
//  GuGong
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 gokaola. All rights reserved.
//

#import "NetworkRequest.h"
#import "JSONKit.h"
#import "SBJson.h"
#import "SBJsonParser.h"
#import "Tools.h"

#define URL @"http://115.28.37.180/itfc/mobile/HTTPService.action"

@interface NetworkRequest()
@property (nonatomic, strong) InfoNetWorking *infoNetWork;
@property (nonatomic, assign) id<NetworkRequestDelegate> delegate;

@end

@implementation NetworkRequest

- (id)initWithDelegate:(id<NetworkRequestDelegate>)delegate{
    self = [super init];
    
    if (self) {
        self.infoNetWork = [[InfoNetWorking alloc] initWithDelegate:self :URL];
        self.delegate = delegate;
    }
    
    return self;
}

- (void)requestDataFromServerWithInfo:(NSDictionary *)requestDic{
    
    NSString *bodyString = [Tools sendDataWithStr:requestDic];
    
    [self.infoNetWork callservicewithbody:bodyString];
    
}

-(void)callFinish:(InfoNetWorking *)caller withData:(NSData *)data
{
    NSString *strdata=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *reciveDic =[NSMutableDictionary dictionaryWithDictionary:[strdata objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode]];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    id recieveData = [jsonParser objectWithString:[reciveDic objectForKey:@"success"] ];
   // NSLog(@"%@",reciveDic) ;
   // NSLog(@"%@",recieveData) ;
    
    if ([self.delegate respondsToSelector:@selector(requestSuccessWithInfo:)]) {
        [self.delegate requestSuccessWithInfo:recieveData];
    }

}
-(void)callFailed:(id)caller withError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(requestFailWithError:)]) {
        [self.delegate requestFailWithError:error];
    }
}

@end
