//
//  PPMapListViewController.h
//  PPTour
//
//  Created by g5-1 on 14/11/4.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSTableViewDelegate.h"
@interface PPMapListViewController : UIViewController
@property (nonatomic ,strong) NSString* title ;
@property (nonatomic ,strong) NSMutableArray* dataArr ;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel* titleLab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) JSTableViewDelegate* tvcDelegate ;
@end
