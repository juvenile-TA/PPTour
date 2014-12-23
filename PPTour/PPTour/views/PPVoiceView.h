//
//  PPVoiceView.h
//  PPTour
//
//  Created by g5-1 on 14/11/3.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VoiceBtnClickDelegate <NSObject>
- (void)voiceDoButton:(UIButton*)btn ;
@end

@interface PPVoiceView : UIView
@property (nonatomic ,retain) id<VoiceBtnClickDelegate> VoiceDelegate ;
-(id)initFromNib ;
@end
