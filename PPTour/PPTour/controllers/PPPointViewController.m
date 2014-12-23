//
//  PPPointViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPPointViewController.h"
#import "AudioStreamer.h"
@interface PPPointViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pointImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIWebView *pointWebView;
@property (weak, nonatomic) IBOutlet UIView *playView;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) BOOL isLike;
@end

@implementation PPPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.titleLabel.text = self.palaceInfo[@"note"];
    [self updateUI ];
   // self.slider.value = streamer.;
    
}
- (void)updateUI{
    NSString *imageHead=@"";
    if ([[[self.palaceInfo objectForKey:@"headimg"] substringToIndex:4]isEqualToString:@"http"]) {
        imageHead=[self.palaceInfo objectForKey:@"headimg"];
    }else{
        imageHead=[NSString stringWithFormat:@"http://115.28.37.180:80/%@",[self.palaceInfo objectForKey:@"headimg"]];
    }
    //NSLog(@"%@",imageHead) ;
    [self.pointImageView setImageWithURL:[NSURL URLWithString:imageHead] placeholderImage:[UIImage imageNamed:@"placeholderImage.png"]];
    [self.pointWebView loadHTMLString:self.palaceInfo[@"innerhtml"] baseURL:nil];
    
    self.slider.value = 0;
    CGRect rect = self.pointImageView.frame;
    self.pointImageView.frame = CGRectMake(rect.origin.x, rect.origin.y, 0, rect.size.height);
    [self.view removeGestureRecognizer:self.tapGestureRecognizer];
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pressTouchEvent:)];
//    [self.playView addGestureRecognizer:pan];
    
    [self placeDetailMusicButtonClick:nil];
    
    NSDictionary *likeInfo = [[NSUserDefaults standardUserDefaults] objectForKey:self.palaceInfo[@"note"]];
    if (likeInfo == nil) {
        [self.likeBtn setImage:[UIImage imageNamed:@"unLike.png"] forState:UIControlStateNormal];
        self.isLike = NO;
    }else{
        [self.likeBtn setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        self.isLike = YES;
    }
}
- (IBAction)sliderChange:(UISlider *)sender {

    self.player.currentTime = sender.value;
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self destroyStreamer];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - IB Action

- (IBAction)likeButtonClicked:(id)sender {
    if (self.isLike) {
        [self.likeBtn setImage:[UIImage imageNamed:@"unLike.png"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:self.palaceInfo[@"note"]];
    }else{
        [self.likeBtn setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:self.palaceInfo[@"note"]];
    }
    self.isLike = !self.isLike;
}


- (IBAction)placeDetailMusicButtonClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    if (self.isPlaying) {
        [button setImage:[UIImage imageNamed:@"play_btn_fine.png"] forState:UIControlStateNormal];
        //[streamer pause];
        [_player pause ];
        self.isPlaying = NO;
    }else{
        [button setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        //[streamer start];
        [_player play ];
        self.isPlaying = YES;
    }
    
//    if (streamer)
//    {
//        return;
//    }
//    
    NSString *urlString = self.palaceInfo[@"links"];
    
    NSURL *url = [NSURL URLWithString:urlString];
   // streamer = [[AudioStreamer alloc] initWithURL:url];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil ];
    [_player play ];
   // [streamer start];
    
    self.progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}
//-(void)pressTouchEvent:(UIPanGestureRecognizer *) pan{
//    CGPoint point = [pan locationInView:self.playView];
//    
//    CGRect rect = self.playView.frame;
//    
//    CGFloat offset = point.x / self.playView.frame.size.width;
//    
//    [self.progressUpdateTimer invalidate];
//    
//    if (pan.state == UIGestureRecognizerStateEnded ) {
//        self.progressUpdateTimer = nil;
//        self.progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
//    }
//    
//    if (point.x>0 && point.x < rect.size.width) {
////        self.playedImageView.frame = CGRectMake(self.playedImageView.frame.origin.x, self.playedImageView.frame.origin.y, point.x, self.playedImageView.frame.size.height);
////        self.playIconImageView.frame = CGRectMake(point.x + 45, self.playIconImageView.frame.origin.y, self.playIconImageView.frame.size.width, self.playIconImageView.frame.size.height);
//        [self updatePlayTime:offset];
//    }
//    
//}
///===================================================================================
//- (void)back:(id)sender {
//    [streamer stop];
//    [self.navigationController popViewControllerAnimated:YES];
//}
#pragma mark - play Audio

//- (void)updatePlayTime:(float)offset{
//    if (streamer.bitRate != 0.0){
//        double duration = streamer.duration;
//        [streamer seekToTime:offset * duration];
//    }
//}

- (void)playSound {
    //如果流存在，我们先释放掉
//    if (streamer)
//    {
//        return;
//    }
    //	[self destroyStreamer];
    
    NSURL *url = [NSURL URLWithString:@"http://image.uuu9.com/games/jr/UploadFiles/200711/200711121847405461.mp3"];
//    streamer = [[AudioStreamer alloc] initWithURL:url];
//    [streamer start];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil ];
    [_player play ];
    
    //就是为了更新slider的进度条
    self.progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    
}


- (void)updateProgress {
//    if (streamer.bitRate != 0.0)
//    {
//        //增长
//        double progress = streamer.progress;
//        //持续时间
//        double duration = streamer.duration;
//        if (progress/duration<1)
//        {
//            [self.slider setEnabled:YES];
//            CGRect rect = self.playView.frame;
//            
//            float offset = progress / duration * rect.size.width;
//            
////            self.playedImageView.frame = CGRectMake(self.playedImageView.frame.origin.x, self.playedImageView.frame.origin.y, offset, self.playedImageView.frame.size.height);
////            self.playIconImageView.frame = CGRectMake(offset + 45, self.playIconImageView.frame.origin.y, self.playIconImageView.frame.size.width, self.playIconImageView.frame.size.height);
//            
//        }
//        else
//        {
//            [self.slider setEnabled:NO];
//        }
//    }
    self.slider.value = self.player.currentTime;
}

//#pragma mark - 摧毁流
//- (void)destroyStreamer
//{
//    if (streamer)
//    {
//        [[NSNotificationCenter defaultCenter]
//         removeObserver:self
//         name:ASStatusChangedNotification
//         object:streamer];
//        [self.progressUpdateTimer invalidate];
//        self.progressUpdateTimer = nil;
//        streamer = nil;
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
