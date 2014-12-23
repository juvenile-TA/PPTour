//
//  InfoNetWorking.m
//  
//
//  Created by wuxiang on 13-6-13.
//  Copyright (c) 2013年 wuxiang. All rights reserved.
//

#import "InfoNetWorking.h"


@implementation InfoNetWorking
@synthesize deviceId;
@synthesize userInfo;
@synthesize appVersion;
@synthesize isUseCentralPlatform,httpLocation,connectionDelegate;
NSString *centralPlatform = @"@";
NSString *centralPlatformService = @"";
- (id) initWithDelegate: (id)delegate :(NSString*)currentUrl
{
	self = [super init];
	
	if (self)
	{
		httpLocation =  [[NSString alloc] initWithString:currentUrl];//url;
		connectionDelegate = delegate;
		urlConnection = nil;
		receiveData = [NSMutableData data];
        self.isUseCentralPlatform = NO;
		
		//NSLog(@"%@",userInfo);
	}
	
	return self;
}

- (NSString *)callServicebody:(NSString *)body error:(NSString **)errorString {
	NSURL *url = [[NSURL alloc] initWithString:HTTPL];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	[request setHTTPMethod:@"PUT"];
    NSLog(@"body %@",body);
//	NSString *strbody=[body JSONString];
//    NSLog(@"strbody %@",strbody);
    const char *utf8String = [body UTF8String];
	NSData *bodyData = [[NSData alloc] initWithBytes:utf8String length:strlen(utf8String)];
	[request setHTTPBody:bodyData];
	NSURLResponse *response = nil;
	NSError *error = nil;
	NSData *resultData = [NSURLConnection sendSynchronousRequest:request
											   returningResponse:&response
														   error:&error];
	*errorString = nil;
	if (nil != resultData) {
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
		if (NO == [httpResponse isKindOfClass:[NSHTTPURLResponse class]] || httpResponse.statusCode != 200) {
			switch (httpResponse.statusCode) {
				case 500:
					*errorString = @"服务器处理异常！";
					break;
				case 403:
					*errorString = @"请求被服务器拒绝！";
					break;
				case 404:
					*errorString = @"请求的服务不存在！";
					break;
				default:
					break;
			}
		}
		else {
		}
	}
	else {
		*errorString = [error localizedDescription];
	}
	if (nil != *errorString) {
		resultData = nil;
	}
	//[error release];
	//[response release];
    NSLog(@"errorString %@",*errorString);
//    NSLog(@"resultData %@",resultData);
    NSString *strdata=[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
//    NSLog(@"strdata %@",strdata);
	return strdata;
}



#pragma mark - 判断是否连接网络
- (BOOL) connectedToNetwork

{
    
    // Create    zero   addy
    
    struct   sockaddr_in   zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    
    zeroAddress.sin_len = sizeof(zeroAddress);
    
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability   flags
    
    SCNetworkReachabilityRef   defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(
                                                                                                 
                                                                                                 NULL,
                                                                                                 
                                                                                                 (struct sockaddr*)&zeroAddress);
    
    SCNetworkReachabilityFlags   flags;
    
    BOOL   didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
        
    {
        
        NSLog(@"Error. Could not recover network reachability flags");
        
        return  NO;
        
    }
    
    BOOL   isReachable = flags  &  kSCNetworkFlagsReachable;
    
    BOOL   needsConnection = flags  & kSCNetworkFlagsConnectionRequired;
    
    BOOL   nonWiFi = flags  &  kSCNetworkReachabilityFlagsTransientConnection;
    
    NSURL   *testURL = [NSURL URLWithString:@"http://www.baidu.com/"];
    
    NSURLRequest   *testRequest = [NSURLRequest   requestWithURL:testURL
                                   
                                                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
                                   
                                                 timeoutInterval:20.0];
    
    NSURLConnection   *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:self];
    
    return  ((isReachable  &&  !needsConnection) || nonWiFi)  ?  (testConnection  ?  YES : NO) : NO;
    
}







#pragma mark -
#pragma mark http method Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    NSLog(@"allHeaderFields %@",httpResponse.allHeaderFields);
	if (NO == [httpResponse isKindOfClass:[NSHTTPURLResponse class]] || httpResponse.statusCode != 200) {
		[connection cancel];
		NSString *errorString = nil;
		
		switch (httpResponse.statusCode) {
			case 500:
				errorString = @"服务器处理异常！";
				break;
			case 403:
				errorString = @"请求被服务器拒绝！";
				break;
			case 404:
				errorString = @"请求的服务不存在！";
				break;
			default:
				break;
		}
		NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:errorString, NSLocalizedDescriptionKey, nil];
		NSError *error = [[NSError alloc] initWithDomain:NSURLErrorDomain code:httpResponse.statusCode userInfo:dic];
		[self connection:connection didFailWithError:error];
        //		[error release];
        //		[dic release];
        //		[errorString release];
	}
    else
    {
        
        [receiveData setLength:0];
    }

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    NSLog(@"receiveData %@",data);
	[receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *log = [[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
    if ([Tools isRecevieStr:log]) {
        NSLog(@"connectionDidFinishLoading \n网络请求结果：\n%@\n\nEND＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝\n\n\n", log);
        if ([connectionDelegate respondsToSelector:@selector(callFinish:withData:)]) {
            [connectionDelegate callFinish:self withData:receiveData];
        }
        urlConnection = nil;
        [receiveData setLength:0];
    }
    if ([connectionDelegate respondsToSelector:@selector(callIsConnect:)]) {
        [connectionDelegate callIsConnect:YES];
    }


}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if ([connectionDelegate respondsToSelector:@selector(callFailed:withError:)]) {
		[connectionDelegate callFailed:self withError:error];
	}
	else {
		NSString *errorString = [error localizedDescription];
		NSString *strBody = [NSString stringWithFormat:@"<Response> <flag code='-1' msg='%@' /></Response>", errorString];
		[receiveData setLength:0];
		const char *utf8String = [strBody UTF8String];
		[receiveData appendBytes:utf8String length:strlen(utf8String)];

		[self connectionDidFinishLoading:connection];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	NSURLCredential *credential = [[NSURLCredential alloc] initWithTrust:nil];
	[[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    //	[credential release];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
	return YES;
}
#pragma mark Connect method
- (void)callhttpservice:(NSData *)body
{
	//[self getUserInfo];
    //    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *temp= nil;
    if(isUseCentralPlatform)
    {
        temp = centralPlatformService;
    }
    else
    {
        temp = httpLocation;
    }
    
	NSString *urlString = [[NSString alloc] initWithFormat:@"%@", temp];
    
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
	
	
    NSString *log = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];// enc];
	NSLog(@"\nBEGIN＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝\n网络请求地址：\n%@\n\n网络请求参数：\n%@\n\n", urlString, log);
    //	[log release];
	
    
    //	[urlString release];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	
    //    [url release];
    [request setHTTPBody:body];
	[request setHTTPMethod:@"POST"];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    
	if (0 != [body length]) {
        
        //        NSData *aesData = [body AES256EncryptWithKey:@"1234567"];
        //        NSData *deaesData = [aesData AES256DecryptWithKey:@"1234567"];
        
        //        [request setHTTPBody:body];
        [request setHTTPBody:body];
	}
	[request setTimeoutInterval:60];
	
	urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //	[request release];
	////NSLog(@"sendRequest---------\nconnection: %@\nurl: %@", urlConnection, [request URL]);
}


- (void)callservicewithbody:(NSString *)body
{
    //     NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
	//const char *utf8String = [body UTF8String];
	//NSData *bodyData = [[NSData alloc] initWithBytes:utf8String length:strlen(utf8String)];
	
    const char *utf8String = [body cStringUsingEncoding: NSUTF8StringEncoding];//enc];
	NSData *bodyData = [[NSData alloc] initWithBytes:utf8String length:strlen(utf8String)];
    
    
    [self callhttpservice:bodyData];
    //	[bodyData release];
}

- (void)getContentOf:(NSString *)url
{
	NSURL *uri = [[NSURL alloc] initWithString:url];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:uri];
    //	[uri release];
	[request setHTTPMethod:@"GET"];
	
	urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //	[request release];
}

- (void)callserviceGetNewUrlWithUser:(NSString *)body
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    const char *utf8String = [body cStringUsingEncoding:enc];
	NSData *bodyData = [[NSData alloc] initWithBytes:utf8String length:strlen(utf8String)];
    
    NSString *myVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    NSString *urlString = [[NSString alloc] initWithFormat:centralPlatform,body,myVersion];
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	
	//NSString *log = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    NSString *log = [[NSString alloc] initWithData:bodyData encoding:enc];
	NSLog(@"\nBEGIN＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝\n网络请求地址：\n%@\n\n网络请求参数：\n%@\n\n", urlString, log);
    //	[log release];
    //	[urlString release];
    
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //    [url release];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[request setHTTPMethod:@"POST"];
    NSString *contentType = [NSString stringWithFormat:@"application/octet-stream"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
	if (0 != [body length]) {
        
		[request setHTTPBody:bodyData];
	}
	[request setTimeoutInterval:60];
	
	urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //	[request release];
    //	[bodyData release];
}
- (void) dealloc
{
	connectionDelegate = nil;
	if( nil != urlConnection)
    {
        [urlConnection cancel];
        //		[urlConnection release];？、
    }
}
- (void)cancelConnection {
	if( nil != urlConnection )
	{
		////NSLog(@"cancelConnection---------\nconnection: %@", urlConnection);
		[urlConnection cancel];
        //		[urlConnection release];
		urlConnection = nil;
	}
}
-(NSString *)connectServerWithHttpLine:(NSString *)URL
{
    NSURL *downMessageTxTURL = [NSURL URLWithString:URL];
    NSString *messageConfigStr=[[NSString alloc]initWithData:[NSData dataWithContentsOfURL:downMessageTxTURL] encoding:NSUTF8StringEncoding];
    return messageConfigStr;
}

@end
