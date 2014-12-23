//
//  PPCallbcakViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPCallbcakViewController.h"

@interface PPCallbcakViewController ()

@end

@implementation PPCallbcakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _contentTV.layer.masksToBounds = YES;
    _contentTV.layer.cornerRadius = 6.0;
    _contentTV.layer.borderWidth = 0.5f;
    _contentTV.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    _pNumTF.delegate = self;
    _contentTV.delegate = self;
    
//    self.commitBGView.layer.masksToBounds = YES;
//    self.commitBGView.layer.cornerRadius = 6.0;
    
    self.requstClient = [[NetworkRequest alloc] initWithDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

}
- (void)dismissKeyboard{
    [_pNumTF resignFirstResponder];
    [_contentTV resignFirstResponder];
}
//-(void)textViewDidChange:(UITextView *)textView {
//    _contentTV.text = textView.text;
//    if ([self.contentTextView.text length] == 0) {
//        self.placeholderLabel.text = @"请输入您的宝贵意见";
//    }else {
//        self.placeholderLabel.text = @"";
//    }
//}
- (IBAction)commitButtonClicked:(id)sender {
    
    NSString *contentString = [_contentTV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (contentString == nil || [contentString isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入内容为空" message:@"请您重新输入" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alertView show];
    }
    NSString *phoneString = [_pNumTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (phoneString == nil) {
        phoneString = @"";
    }
    NSString *commitString = [NSString stringWithFormat:@"{\\\"mphone\\\":\\\"%@\\\",\\\"minnertext\\\":\\\"%@\\\"}",phoneString,contentString];
    [self.requstClient requestDataFromServerWithInfo:@{@"data":commitString,@"serviceCode":@"com.ggo.http.service.mobile.HttpService,msg"}];
    
}

#pragma mark - Network Call Back
- (void)requestSuccessWithInfo:(id)info{
    [self HUDshowSucessWithStatus:@"提交成功"];
}

- (void)requestFailWithError:(NSError *)error{
    NSLog(@"%@",error.description);
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
