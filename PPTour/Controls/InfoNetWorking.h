//
//  InfoNetWorking.h
//  
//
//  Created by wuxiang on 13-6-13.
//  Copyright (c) 2013年 wuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"


#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import "InfonetWorkingDelegate.h"
#import "Tools.h"


#define HTTPL @"http://115.28.37.180/itfc/mobile/HTTPService.action"


@interface InfoNetWorking : NSObject
{
    NSString *httpLocation;
    id <InfonetWorkingDelegate> connectionDelegate;
    NSMutableData *receiveData;
    NSURLConnection *urlConnection;
    NSString* deviceId;
    NSString *userInfo;
    NSString *appVersion;
    BOOL isUseCentralPlatform;
}

@property(strong,nonatomic)NSMutableArray *mutableActivityModel;
@property int activity_page;
@property(strong,nonatomic) id <InfonetWorkingDelegate> connectionDelegate;
@property (nonatomic, retain) NSString *httpLocation;
@property (nonatomic) BOOL isUseCentralPlatform;
@property (nonatomic, retain) NSString *deviceId;
@property (nonatomic, retain) NSString *userInfo;
@property (nonatomic, retain) NSString *appVersion;
- (NSString *)callServicebody:(NSString *)body error:(NSString **)errorString;

//- (id)initWithDelegate:(id)delegate;
- (id) initWithDelegate: (id)delegate :(NSString*)currentUrl;
- (void)cancelConnection;
- (void)callservicewithbody:(NSString *)body;
- (BOOL)connectedToNetwork;
- (void)getContentOf:(NSString *)url;
- (void)callserviceGetNewUrlWithUser:(NSString *)body;
-(NSString *)connectServerWithHttpLine:(NSString *)URL;

@end

