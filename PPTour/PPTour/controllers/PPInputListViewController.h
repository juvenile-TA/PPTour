//
//  PPInputListViewController.h
//  PPTour
//
//  Created by g5-1 on 14/11/4.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPInputListViewController : UIViewController
@property (nonatomic ,strong) NSString* title ;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
