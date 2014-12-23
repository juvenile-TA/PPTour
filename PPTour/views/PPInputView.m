//
//  PPInputView.m
//  PPTour
//
//  Created by g5-1 on 14/11/3.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPInputView.h"

@implementation PPInputView

-(id)initFromNib
{
    self = [[PPInputView alloc]init ];
    if(self){
        NSString* wordsPath = [[NSBundle mainBundle]pathForResource:@"words" ofType:@"plist" ];
        NSArray* btn_title = [NSArray arrayWithContentsOfFile:wordsPath ] ;
        for (int i = 0 ; i < btn_title.count ; i ++) {
            UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(i%6*51+7, i/6*51+7, 50, 50)] ;
            [self addSubview:btn ] ;
            btn.backgroundColor = [UIColor cyanColor] ;
            btn.tag = i ;
            [btn setTitle:[NSString stringWithFormat:@"%@",btn_title[i]] forState:UIControlStateNormal ];
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside ];
        }
        UISearchBar* searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 375, 320, 44) ] ;
        [self addSubview:searchBar ] ;
    }   
    return self;
}
- (void)buttonClicked:(UIButton*)btn {
    if([self.InputDelegate respondsToSelector:@selector(inputDoButton:)])
    {
        NSLog(@"%@",btn.titleLabel.text) ;
        [self.InputDelegate inputDoButton:btn];
    }
}

@end
