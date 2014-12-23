    //
//  PPVoiceListView.h
//  PPTour
//
//  Created by g5-1 on 14/11/18.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSTableViewDelegate.h"
@protocol VoiceCellDidDelegate <NSObject>
- (void)voiceCellDid:(id)btn ;
@end

@interface PPVoiceListView : UIView
@property (nonatomic ,retain) id<VoiceCellDidDelegate> VoiceListDelegate ;
@property (nonatomic ,strong) JSTableViewDelegate* tvcDelegate ;
@end
