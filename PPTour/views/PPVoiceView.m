//
//  PPVoiceView.m
//  PPTour
//
//  Created by g5-1 on 14/11/3.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPVoiceView.h"

@implementation PPVoiceView
-(id)initFromNib
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"PPVoiceView" owner:self options:nil] lastObject];
    if(self){
        
    }
    return self;
}
//- (void)buttonClicked:(UIButton*)btn {
//    //NSLog(@"=======%@=========",btn.titleLabel.text) ;
//
//    
//}
- (IBAction)buttonClicked:(UIButton *)sender {
    if([self.VoiceDelegate respondsToSelector:@selector(voiceDoButton:)])
    {
        [self.VoiceDelegate voiceDoButton:sender];
    }
    
}
@end
