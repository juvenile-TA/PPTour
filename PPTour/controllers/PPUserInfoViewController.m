//
//  PPUserInfoViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/6.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPUserInfoViewController.h"
#import "PPAboutViewController.h"
#import "PPCallbcakViewController.h"
@interface PPUserInfoViewController ()
@property (nonatomic ,strong) NSArray* textArr ;
@end

@implementation PPUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO ;
    self.navigationController.toolbarHidden = NO ;
    [self creareData] ;
    [self configure ] ;

}
- (void)creareData {
    self.textArr = @[@"当前版本   ZXBQ-1.1.001",@"我的收藏",@"我的订单",@"我的消息",@"精品推荐",@"关于我们",@"用户协议",@"意见反馈",@"更多"] ;
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
                return 9;
        }
        return 0;
    };
    void (^TableViewDidSelectConfigurate)(NSIndexPath* )=^(NSIndexPath*  indexPath ){
        NSLog(@"点击了第 %d 区 ，第 %d 行",indexPath.section,indexPath.row);
        if (indexPath.row == 5) {
            PPAboutViewController* about = [self.storyboard instantiateViewControllerWithIdentifier:@"About"] ;
            [self.navigationController pushViewController:about animated:YES ];

        }
        if (indexPath.row == 7) {
            PPCallbcakViewController* callbcak = [self.storyboard instantiateViewControllerWithIdentifier:@"Callbcak"] ;
            [self.navigationController pushViewController:callbcak animated:YES ];
            
        }
    };
    self.tvcDelegate =[[JSTableViewDelegate alloc]initWithItems:_textArr cellIdentifier:@"Cell" numberOfSections:1 numberOfRowsInSectionConfigureBlock:TableViewNumberOfRowsInSectionConfigurate cellConfigureBlock:TableViewCellConfigurate didSelectConfigure:TableViewDidSelectConfigurate];
    self.table.dataSource= self.tvcDelegate;
    self.table.delegate= self.tvcDelegate;
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
