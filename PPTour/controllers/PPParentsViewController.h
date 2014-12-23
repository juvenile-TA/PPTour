//
//  PPParentsViewController.h
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "Tools.h"
#import "WebRequestClient.h"
#import "NetworkRequest.h"
#import "UIImageView+WebCache.h"
@interface PPParentsViewController : UIViewController<MBProgressHUDDelegate,NetworkRequestDelegate>
{
    MBProgressHUD *HUD;
    //如果ios7则+20头部
    int topForiOS7;
}

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) NetworkRequest *requstClient;

-(void)HUDshowWithStatus:(NSString *)string;
-(void)dismissProgressView;
-(void)HUDshowErrorWithStatus:(NSString *)errorString;
-(void)HUDshowSucessWithStatus:(NSString *)sucessString;
- (void)didFailWithErrorDescription:(NSString *)errorString;
- (void)didGetWebData:(NSDictionary *)dic;
- (void)dismissKeyboard;

- (NSMutableDictionary *)safeDictionary:(NSMutableDictionary *)dic;
- (NSDictionary *)responseDataToJson:(id)responseData;

@end