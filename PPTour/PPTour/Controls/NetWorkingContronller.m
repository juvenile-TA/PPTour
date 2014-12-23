//
//  NetWorkingContronller.m
//  GuGongTraval
//
//  Created by wuxiang on 14-4-9.
//  Copyright (c) 2014年 RanshiTEC. All rights reserved.
//

#import "NetWorkingContronller.h"

@interface NetWorkingContronller ()

@end

@implementation NetWorkingContronller
@synthesize reciveDic;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        infoNetWork=[[InfoNetWorking alloc]initWithDelegate:self:HTTPL];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 连接服务器
-(void)connectToSever
{
    
    [infoNetWork callservicewithbody:[self sendServerDataStr:nil]];
}

-(NSString *)sendServerDataStr:(NSDictionary *)userInfoDic
{
    return Nil;
}
#pragma mark - InfonetWorkingDelegate Delegate 连接委托
-(void)callFinish:(InfoNetWorking *)caller withData:(NSData *)data
{
    //接受数据转正字符串
    NSString *strdata=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //删除反斜杠以及"转正正常json字符串
    //    NSLog(@"strdata %@",strdata);
    NSLog(@"strdata %@",strdata);
    //去除所有\\反斜杠
//    NSString *strjson=[Tools strForJsonNormalFromServerJson:strdata];
//    strjson=[Tools str:strjson];
    //字符串转字典
    self.reciveDic =[NSMutableDictionary dictionaryWithDictionary:[strdata objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode]];
    NSLog(@"callFinish recive data %@",self.reciveDic);
    //解析数据
    [self analysisDataFromServer];
}
-(void)callFailed:(id)caller withError:(NSError *)error
{
    NSLog(@"callFailed %@",error);

}
#pragma mark - analysis data 解析数据
-(void)analysisDataFromServer
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
