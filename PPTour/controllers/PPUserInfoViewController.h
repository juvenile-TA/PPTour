//
//  PPUserInfoViewController.h
//  PPTour
//
//  Created by g5-1 on 14/11/6.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSTableViewDelegate.h"
@interface PPUserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic ,strong) JSTableViewDelegate* tvcDelegate ;
@end
