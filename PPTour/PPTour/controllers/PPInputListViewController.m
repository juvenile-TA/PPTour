//
//  PPInputListViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/4.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPInputListViewController.h"
#import "JSTableViewDelegate.h"
#import "PPAreaHomeViewController.h"
@interface PPInputListViewController ()
@property (nonatomic ,strong) NSArray* textArr ;
@property (nonatomic ,strong) JSTableViewDelegate* tvcDelegate ;
@end

@implementation PPInputListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = self.title ;
    [self creareData ];
    [self configure ];
}
- (void)creareData {
    self.textArr = @[@"我的收藏",@"我的订单",@"我的消息",@"精品推荐",@"关于我们",@"用户协议"] ;
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
                return 5 ;
        }
        return 0;
    };
    void (^TableViewDidSelectConfigurate)(NSIndexPath* )=^(NSIndexPath*  indexPath ){
        PPAreaHomeViewController* areaHome = [self.storyboard instantiateViewControllerWithIdentifier:@"AreaHome"] ;
        [self.navigationController pushViewController:areaHome animated:YES ];
    };
    self.tvcDelegate =[[JSTableViewDelegate alloc]initWithItems:_textArr cellIdentifier:@"inputlistCell" numberOfSections:1 numberOfRowsInSectionConfigureBlock:TableViewNumberOfRowsInSectionConfigurate cellConfigureBlock:TableViewCellConfigurate didSelectConfigure:TableViewDidSelectConfigurate];
    self.tableView.dataSource= self.tvcDelegate;
    self.tableView.delegate= self.tvcDelegate;
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
