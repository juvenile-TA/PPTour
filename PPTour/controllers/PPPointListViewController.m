//
//  PPPointListViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPPointListViewController.h"
#import "PPPointViewController.h"
@interface PPPointListViewController ()

@end

@implementation PPPointListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)creareData {
    //_pointArray = [[NSMutableArray alloc]init ] ;
    //_pointArray = @[@"我的收藏",@"我的订单",@"我的消息",@"精品推荐",@"关于我们",@"用户协议"] ;
}
-(void)configure{
    void (^TableViewCellConfigurate)(UITableViewCell*, NSString* )=^(UITableViewCell*cell,NSString*data){
        //for (int i = 0 ; i < textArr.count ; i ++) {
        cell.textLabel.text = data ;
        //}
    };
    int (^TableViewNumberOfRowsInSectionConfigurate)(NSInteger )=^(NSInteger section){
        switch (section) {
            case 0:
                return 9 ;
        }
        return 0;
    };
    void (^TableViewDidSelectConfigurate)(NSIndexPath* )=^(NSIndexPath*  indexPath ){
        NSLog(@"点击了第 %d 区 ，第 %d 行",indexPath.section,indexPath.row);
        int row=indexPath.row;
        PPPointViewController * point = [self.storyboard instantiateViewControllerWithIdentifier:@"Point"];
        point.palaceInfo = [self.pointArray objectAtIndex:row];
        [self.navigationController pushViewController:point animated:YES];
    };
    self.tvcDelegate =[[JSTableViewDelegate alloc]initWithItems:_pointArray cellIdentifier:@"Cell" numberOfSections:1 numberOfRowsInSectionConfigureBlock:TableViewNumberOfRowsInSectionConfigurate cellConfigureBlock:TableViewCellConfigurate didSelectConfigure:TableViewDidSelectConfigurate];
    self.pointListTV.dataSource= self.tvcDelegate;
    self.pointListTV.delegate= self.tvcDelegate;
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
