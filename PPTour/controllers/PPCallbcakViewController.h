//
//  PPCallbcakViewController.h
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPParentsViewController.h"

@interface PPCallbcakViewController : PPParentsViewController<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *pNumTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;

@end
