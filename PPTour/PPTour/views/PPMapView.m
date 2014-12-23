//
//  PPMapView.m
//  PPTour
//
//  Created by g5-1 on 14/11/3.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPMapView.h"
@implementation PPMapView
-(id)initFromNib
{
    if(self){
        self = [[PPMapView alloc]init ];
        NSString* placeNamePath = [[NSBundle mainBundle]pathForResource:@"placeName" ofType:@"plist" ];
        NSDictionary* root = [NSDictionary dictionaryWithContentsOfFile:placeNamePath] ;
        NSArray* btn_title = [root objectForKey:@"areas"];
        for (int i = 0 ; i < btn_title.count ; i ++) {
            UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(i%5*65, i/5*60, 60, 55)] ;
            [self addSubview:btn ] ;
            btn.backgroundColor = [UIColor greenColor] ;
            btn.tag = i ;
            [btn setTitle:[NSString stringWithFormat:@"%@",btn_title[i]] forState:UIControlStateNormal ];
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside ];
        }
    }
    return self;
}
- (void)buttonClicked:(UIButton*)btn {
    //NSLog(@"=======%@=========",btn.titleLabel.text) ;
    if([self.MapDelegate respondsToSelector:@selector(mapDoButton:)])
    {
        [self.MapDelegate mapDoButton:btn];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
