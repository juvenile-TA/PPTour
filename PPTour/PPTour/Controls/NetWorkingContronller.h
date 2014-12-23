//
//  NetWorkingContronller.h
//  GuGongTraval
//
//  Created by wuxiang on 14-4-9.
//  Copyright (c) 2014年 RanshiTEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoNetWorking.h"
#import "JSONKit.h"
@interface NetWorkingContronller : UIViewController<InfonetWorkingDelegate>
{
    InfoNetWorking *infoNetWork;
    NSMutableDictionary *reciveDic;
}
@property (strong,nonatomic) NSMutableDictionary *reciveDic;
-(void)connectToSever;
@end
