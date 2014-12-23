
//
//  PPHomeViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/3.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPHomeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PPFindViewController.h"
#import "PPTotalCollectionViewController.h"
#import "PPUserInfoViewController.h"
@interface PPHomeViewController ()
//@property (strong ,nonatomic) AVAudioPlayer* mainPlayer ;
@property (nonatomic ,strong) NSNumber* btn_tag ;
@end
@implementation PPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //voice start
  //  [self playMusic];
}
-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES ;
    self.navigationController.toolbarHidden = YES ;
}
//语音开始播放
//- (void)playMusic {
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"mp3"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    self.mainPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//    [self.mainPlayer prepareToPlay];
//    [self.mainPlayer play];
//}
//界面跳转时语音停止
//- (void)viewWillDisappear:(BOOL)animated{
//    [_mainPlayer stop];
//}
- (IBAction)jumpUserInfo:(id)sender {
    PPUserInfoViewController* userInfo = [self.storyboard instantiateViewControllerWithIdentifier:@"UserInfo"] ;
    [self.navigationController pushViewController:userInfo animated:YES ];
}
- (IBAction)jumpTotal:(id)sender {
    PPTotalCollectionViewController* total = [self.storyboard instantiateViewControllerWithIdentifier:@"Total" ] ;
    [self.navigationController pushViewController:total animated:YES ];
    
}

- (IBAction)jumpFind:(UIButton *)sender {
    self.btn_tag = [NSNumber numberWithInt:sender.tag ] ;
    [self performSegueWithIdentifier:@"push" sender:self.btn_tag ] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"push"]) {
        PPFindViewController* vc = segue.destinationViewController ;
        vc.num = sender ;
    }

}


@end
