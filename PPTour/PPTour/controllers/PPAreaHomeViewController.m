//
//  PPAreaHomeViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPAreaHomeViewController.h"
#import "PPLineViewController.h"
#import "PPSummaryACardViewController.h"
#import "PPVoiceGuideViewController.h"
@interface PPAreaHomeViewController ()
@property (nonatomic ,strong) NSNumber* AreaBtn_tag ;
@end

@implementation PPAreaHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height > 490) {
        self.bgImageView.image = [UIImage imageNamed:@"Default-568h.png"];
    }else{
        self.bgImageView.image = [UIImage imageNamed:@"Default~iphone.png"];
    }
}
- (void)playMusic {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    _mainPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_mainPlayer prepareToPlay];
    [_mainPlayer play];
}
- (void)viewWillDisappear:(BOOL)animated{
    [_mainPlayer stop];
}
- (IBAction)jump:(UIButton *)sender {
    self.AreaBtn_tag = [NSNumber numberWithInt:sender.tag ] ;
    [self performSegueWithIdentifier:@"pushSAC" sender:self.AreaBtn_tag ] ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"pushSAC"]) {
        PPSummaryACardViewController* vc = segue.destinationViewController ;
        NSLog(@"%@",sender) ;
        vc.num = sender ;
    }
    
}

@end
