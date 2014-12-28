//
//  ViewController.m
//  ceshi
//
//  Created by 李棒 on 14-11-21.
//  Copyright (c) 2014年 李棒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    btn.backgroundColor=[UIColor grayColor];
    [btn setTitle:@"go" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)goBtn:(UIButton*)sender
{
    self.view.alpha = 0.5;
    UIView*v=[[UIView alloc]initWithFrame:CGRectMake(50, 100, 220, 200)];
    UIAlertController*ac=[UIAlertController alertControllerWithTitle:@"kaishi" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    
    


    
    [self presentViewController:ac animated:YES completion:nil];
    
    
    



    
    
    
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
