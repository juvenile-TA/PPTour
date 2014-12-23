//
//  PPPointViewController.h
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPParentsViewController.h"
#import <AVFoundation/AVFoundation.h> 
@class AudioStreamer;
@interface PPPointViewController : PPParentsViewController
{
    //音频流
    AudioStreamer *streamer;
    //循环调用
}
@property (nonatomic, strong)AVAudioPlayer *player;
@property (nonatomic, strong) NSDictionary *palaceInfo;
@property (nonatomic, assign)float sliderValue;
@property (nonatomic, strong)NSTimer *progressUpdateTimer;
@end
