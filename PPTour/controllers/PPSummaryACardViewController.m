//
//  PPSummaryACardViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPSummaryACardViewController.h"
#import "PPPointViewController.h"
@interface PPSummaryACardViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *scImageView;
@property (weak, nonatomic) IBOutlet UIWebView *scInfoWebView;

@end

@implementation PPSummaryACardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"lalala" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = rightItem;
    // Do any additional setup after loading the view.
    self.requstClient = [[NetworkRequest alloc] initWithDelegate:self];
    NSLog(@"%@",_num) ;
    if ([_num intValue ] == 1) {
        [self.requstClient requestDataFromServerWithInfo:@{@"data":@"gailan",@"serviceCode":@"com.ggo.http.service.mobile.HttpService,findList_GGAO"}];
        return ;
    }else{
        [self.requstClient requestDataFromServerWithInfo:@{@"data":@"huzhao",@"serviceCode":@"com.ggo.http.service.mobile.HttpService,findList_GGAO"}];
        return ;
    }
    [self HUDshowWithStatus:@"正在加载..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Network Call Back
- (void)requestSuccessWithInfo:(id)info{
    [self dismissProgressView];
    NSDictionary *scInfo = ((NSArray *)info)[0];
    if ([_num intValue ] == 1) {
        [self.scImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://115.28.37.180:80%@",scInfo[@"headimg"] ]] placeholderImage:nil];
    }else{
        [self.scImageView setImageWithURL:[NSURL URLWithString:scInfo[@"headimg"]] placeholderImage:nil];
    }
    [self.scInfoWebView loadHTMLString:scInfo[@"innerhtml"] baseURL:nil];
}

- (void)requestFailWithError:(NSError *)error{
    [self HUDshowErrorWithStatus:error.description];
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
