//
//  PPLineViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPLineViewController.h"

@interface PPLineViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *lineWebView;

@end

@implementation PPLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.requstClient = [[NetworkRequest alloc] initWithDelegate:self];
    [self.requstClient requestDataFromServerWithInfo:@{@"data":@"xianlu",@"serviceCode":@"com.ggo.http.service.mobile.HttpService,findList_GGAO"}];
    [self HUDshowWithStatus:@"正在加载..."];
}
#pragma mark - Network Call Back
- (void)requestSuccessWithInfo:(id)info{
    [self dismissProgressView];
    NSArray *infoArray = (NSArray *)info;
    NSLog(@"%@",infoArray[1][@"innethtml"]);
    [self.lineWebView loadHTMLString:infoArray[1][@"innerhtml"] baseURL:nil];
    
}

- (void)requestFailWithError:(NSError *)error{
    [self HUDshowErrorWithStatus:error.description];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
