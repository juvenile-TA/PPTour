//
//  PPMapView.h
//  PPTour
//
//  Created by g5-1 on 14/11/3.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapBtnClickDelegate <NSObject>
- (void)mapDoButton:(UIButton*)btn ;
@end

@interface PPMapView : UIView

@property (nonatomic ,retain) id<MapBtnClickDelegate> MapDelegate ;
-(id)initFromNib ;
@end
