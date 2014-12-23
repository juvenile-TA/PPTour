//
//  PPVoiceListView.m
//  PPTour
//
//  Created by g5-1 on 14/11/18.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPVoiceListView.h"
#import "PPAreaHomeViewController.h"
@interface PPVoiceListView()

@property (nonatomic ,strong) UIView *blurView;
@property (nonatomic ,strong) UIView* topView ;
@property (nonatomic ,strong) UITableView* bottomTableView ;
@property (nonatomic ,strong) NSArray* dataArr ;
@end
@implementation PPVoiceListView

- (void)drawRect:(CGRect)rect {
    self.blurView = [[UIView alloc]initWithFrame:self.superview.frame];
    self.blurView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
    [self.superview insertSubview:self.blurView belowSubview:self];
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, 100) ];
    [self addSubview:_topView ];
//    _bottomTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, 220, 230) ] ;
//    [self addSubview:_bottomTableView ];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeFormSuperView)];
    [self.blurView addGestureRecognizer:tap];
    
    
}
- (void)removeFormSuperView{
    [self.blurView removeFromSuperview];
    [self removeFromSuperview];
}

@end
