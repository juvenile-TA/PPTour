//
//  PPVoiceListViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/5.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPVoiceListViewController.h"
#import "PPMapListViewController.h"
@interface PPVoiceListViewController ()
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *voiceListView;

@end

@implementation PPVoiceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES ;
    self.navigationController.toolbarHidden = YES ;
}
- (IBAction)jumpFind:(id)sender {
    //_mainView.hidden = YES ;
    _mainView.superview.hidden = YES ;
    self.navigationController.navigationBarHidden = NO ;
    self.navigationController.toolbarHidden = NO ;
    _voiceListView.alpha = 1.0 ;
}
- (IBAction)jumpArea:(id)sender {
    self.navigationController.navigationBarHidden = NO ;
    self.navigationController.toolbarHidden = NO ;
    PPMapListViewController* mapList = [self.storyboard instantiateViewControllerWithIdentifier:@"MapList"] ;
    [self.navigationController pushViewController:mapList animated:YES ];
    mapList.title = _areaLab.text ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
