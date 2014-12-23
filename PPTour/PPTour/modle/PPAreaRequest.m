//
//  PPAreaRequest.m
//  PPTour
//
//  Created by g5-1 on 14/11/5.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPAreaRequest.h"
#import "AFNetworking.h"
@implementation PPAreaRequest
-(void)requestWithArea:(NSString *)Area andCallBack:(CallBack)callback{
        NSString *path = @"http://115.28.37.180:80/iftc/mobile/HTTPService.action" ;
        NSDictionary *params = @{@"data":@"gailan",@"serviceCode":@"com.ggo.http.service.mobile.HttpService,findList_GGAO"} ;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //   去掉头的智能转换
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:Nil];
        NSLog(@"%@",dic) ;
        NSArray *poiDics= [dic objectForKey:@"contents"];
        NSLog(@"%@",poiDics) ;
        NSMutableArray *weibos = [NSMutableArray array];
        for (NSDictionary *poiDic in poiDics) {
//            Area* a = [AreaJsonParser paseWeiboByDictionary:poiDic] ;
//            [weibos addObject:a];
            //            if (![weiboID isEqualToString:@"(null)"]) {
            //                [weibos addObject:weiboID];
            //            }
            //            NSLog(@"%@",weiboID) ;
            
        }
        callback(weibos);
        //        NSArray *Areas= [dic objectForKey:@"result"];
        //        NSMutableArray *names = [NSMutableArray array];
        //        for (NSDictionary *Area in Areas) {
        //            NSString *name = [Area objectForKey:@"name"];
        //            if (![name isEqualToString:@"(null)"]) {
        //                 [names addObject:name];
        //            }
        //        }
        //        callback(names);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"出错：%@",[error localizedDescription]);
    }];
    
}
@end
