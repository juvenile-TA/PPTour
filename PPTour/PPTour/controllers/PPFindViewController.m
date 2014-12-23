//
//  PPFindViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/3.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPFindViewController.h"
#import "PPVoiceView.h"
#import "PPInputView.h"
#import "PPMapView.h"
#import "PPUserInfoViewController.h"
#import "PPVoiceListView.h"
#import "PPTotalCollectionViewController.h"
#import "AppDelegate.h"
#import "PPAreaHomeViewController.h"
#define  SHAREAPP  (AppDelegate*) [[UIApplication sharedApplication] delegate]
@interface PPFindViewController () <InputBtnClickDelegate ,MapBtnClickDelegate ,VoiceBtnClickDelegate,VoiceCellDidDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *findView;
@property (weak, nonatomic) IBOutlet UIView *flushView;
@property (weak, nonatomic) IBOutlet UIView *hiddenView;
@end

@implementation PPFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO ;
    self.navigationController.toolbarHidden = NO ;
    [self flushViewWithNum:_num ] ;
    
}
- (void)flushViewWithNum:(NSNumber*)tempNum{
    if (self.flushView) {
        [self removeSubViewsWith:_flushView ];
        [self didAddViewWithNum:tempNum ] ;
    }
}
- (IBAction)updateView:(UIButton *)sender {
    [self didAddViewWithNum:[NSNumber numberWithInt:sender.tag] ] ;
}
- (IBAction)jumpUserInfo:(id)sender {
    PPUserInfoViewController* userInfo = [self.storyboard instantiateViewControllerWithIdentifier:@"UserInfo"] ;
    [self.navigationController pushViewController:userInfo animated:YES ];
    
}
- (IBAction)jumpTotal:(id)sender {
    PPTotalCollectionViewController* total = [self.storyboard instantiateViewControllerWithIdentifier:@"Total"] ;
    [self.navigationController pushViewController:total animated:YES ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)removeSubViewsWith:(UIView*)view{
    for (int i = 0; i < view.subviews.count; i++) {
        UIView *temp = (UIView *)[view.subviews objectAtIndex:i];
        [temp removeFromSuperview];
    }
}
- (void)didAddViewWithNum:(NSNumber*)tempNum {
    [self removeSubViewsWith:_flushView ];
    int n = [tempNum intValue ] ;
    switch (n) {
        case 0:
        {
            PPVoiceView* tempView = [[PPVoiceView alloc]initFromNib ];
            tempView.frame = _flushView.bounds ;
            tempView.VoiceDelegate = self ;
            [_flushView addSubview:tempView ] ;
        }
            break;
        case 1:
        {
            PPInputView* tempView = [[PPInputView alloc]initFromNib ];
            tempView.frame = _flushView.bounds ;
            tempView.InputDelegate = self ;
            [_flushView addSubview:tempView ] ;
        }
            break;
        case 2:
        {
            PPMapView* tempView = [[PPMapView alloc]initFromNib ];
            tempView.frame = _flushView.bounds ;
            tempView.MapDelegate = self ;
            [_flushView addSubview:tempView ] ;
        }
            break;
    }
}
- (void)voiceDoButton:(UIButton*)btn {
    //_hiddenView.hidden = NO ;
    PPVoiceListView* voiceView = [[PPVoiceListView alloc]initWithFrame:CGRectMake(0, 0, 220, 330) ] ;
    voiceView.center = self.view.center ;
    voiceView.backgroundColor = [UIColor whiteColor] ;
    [SHAREAPP adv:voiceView] ;
    //[self.view addSubview:voiceView ] ;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, voiceView.frame.size.width, voiceView.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [voiceView addSubview:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
static NSString* identifier = @"cellIdentifier";
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"lalala";
    return cell;
}
- (void)mapDoButton:(UIButton*)btn {
    PPMapListViewController* mapList = [self.storyboard instantiateViewControllerWithIdentifier:@"MapList"] ;
    [self.navigationController pushViewController:mapList animated:YES ];
    mapList.title = btn.titleLabel.text ;
}
- (void)inputDoButton:(UIButton*)btn {
    PPInputListViewController* inputList = [self.storyboard instantiateViewControllerWithIdentifier:@"InputList"] ;
    [self.navigationController pushViewController:inputList animated:YES ];
    inputList.title = btn.titleLabel.text ;
}
- (void)voiceCellDid:(id)btn {
    PPAreaHomeViewController* areaHome = [self.storyboard instantiateViewControllerWithIdentifier:@"AreaHome"] ;
    [self.navigationController pushViewController:areaHome animated:YES ];
}




//[SHAREAPP  connect]
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
