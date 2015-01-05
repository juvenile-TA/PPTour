//
//  ViewController.m
//  MasonryDemo
//
//  Created by 杨启晖 on 14/12/1.
//  Copyright (c) 2014年 robert. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     case1:view中心
    */
    [self masCenter];
    /*
     case2:自定义间距
    */
    //[self masEdge];
    /*
     case3:view等宽
    */
    //[self masEqualWidth];
    /*
     case4:scrollview添加view
    */
    //[self masScrollView];
}
- (void)masCenter{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor blackColor];
    view.frame = CGRectMake(0, 0, 100, 100);
    view.center = self.view.center;
    [self.view addSubview:view];
    
//    WS(ws);
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(ws.view);
//        make.width.mas_equalTo(@100);
//        make.height.mas_equalTo(@150);
//    }];
    
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(10, 10, 100, 100);
    [view addSubview:button];
    
}
- (void)masEdge{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    WS(ws);
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view).with.insets(UIEdgeInsetsMake(60, 30, 60, 30));
    }];
}
- (void)masEqualWidth{
    WS(ws);
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:leftView];
    
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = [UIColor redColor];
    [self.view addSubview:rightView];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.view).with.offset(60);
        make.left.mas_equalTo(ws.view.mas_left).with.offset(60);
        make.right.mas_equalTo(rightView.mas_left).with.offset(-10);
        make.height.mas_equalTo(@150);
        make.width.mas_equalTo(rightView);
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.view).with.offset(60);
        make.left.mas_equalTo(leftView.mas_right).with.offset(10);
        make.right.mas_equalTo(ws.view.mas_right).with.offset(-60);
        make.height.mas_equalTo(@150);
        make.width.mas_equalTo(leftView);
    }];
}
-(void)masScrollView{
    WS(ws);
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view);
    }];
    
    UIView *container = [[UIView alloc]init];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView);
    }];
    
    UIView *lastView = nil;
    
    for (int i = 0; i < 10; i ++) {
        UIView *subView = [[UIView alloc]init];
        
        subView.backgroundColor = [UIColor colorWithRed: (CGFloat)random()/(CGFloat)RAND_MAX green: (CGFloat)random()/(CGFloat)RAND_MAX blue: (CGFloat)random()/(CGFloat)RAND_MAX alpha:1];
        
        [container addSubview:subView];
        
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(container);
            make.height.mas_equalTo(@80);
            
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            }else{
                make.top.mas_equalTo(container.mas_top);
            }

        }];
        
        lastView = subView;
    }
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastView.mas_bottom);
    }];
}
@end
