//
//  PPInputView.h
//  PPTour
//
//  Created by g5-1 on 14/11/3.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputBtnClickDelegate <NSObject>
- (void)inputDoButton:(UIButton*)btn ;
@end

@interface PPInputView : UIView

@property (nonatomic ,retain) id<InputBtnClickDelegate> InputDelegate ;
-(id)initFromNib ;

@end
