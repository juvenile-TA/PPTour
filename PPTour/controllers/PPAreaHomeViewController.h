//
//  PPAreaHomeViewController.h
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPParentsViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface PPAreaHomeViewController : PPParentsViewController
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (nonatomic ,strong) AVAudioPlayer* mainPlayer ;
@end
