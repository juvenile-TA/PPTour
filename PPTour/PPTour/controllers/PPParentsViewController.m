//
//  PPParentsViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPParentsViewController.h"

//@interface PPParentsViewController ()
//
//@end
//
//@implementation PPParentsViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end

#import "AppDelegate.h"

@interface PPParentsViewController ()

@end

@implementation PPParentsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // CustomF initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD.delegate = self;
    [self.navigationController.view addSubview:HUD];
    // Do any additional setup after loading the view.
    //    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    //    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7) {
        topForiOS7=20;
    }else{
        topForiOS7=0;
    }
    //self.requstClient = [[DoctorRequestClient alloc] initWithDelegate:self];
}

- (void)dismissKeyboard{
    //子类继重写该函数，用于键盘消失
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)HUDshowWithStatus:(NSString *)string{
    [HUD hide:NO];
    HUD.labelText = string;
    //    HUD.minShowTime=;
    [HUD show:YES];
    //    [HUD showWhileExecuting:@selector(HUDTask) onTarget:self withObject:nil animated:YES];
}
-(void)HUDshowErrorWithStatus:(NSString *)errorString
{
    
    [HUD hide:NO];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD_error"]];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.labelText = errorString;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}
-(void)HUDshowSucessWithStatus:(NSString *)sucessString
{
    
    [HUD hide:NO];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD_Sucess"]];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.labelText = sucessString;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}
-(void)dismissProgressView{
    //    [self hudWasHidden:HUD];
    [HUD hide:NO];
}
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    //	[HUD removeFromSuperview];
    
    //	HUD = nil;
}

#pragma mark -
#pragma mark HUD Execution code
- (void)HUDTask {
    // Do something usefull in here instead of sleeping ...
    sleep(40);
}
-(void)HUDerrorTask
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableDictionary *)safeDictionary:(NSMutableDictionary *)dic{
    NSArray *allKeys = [dic allKeys];
    
    
    for (NSString *key in allKeys){
        
        if ([dic[key] isKindOfClass:[NSDictionary class]] || [dic[key] isKindOfClass:[NSMutableDictionary class]]) {
            dic = [self safeDictionary:dic[key]];
        }
        
        if (dic[key] == nil) {
            if ([dic[key] isKindOfClass:[NSString class]]) {
                dic[key] = @"";
            }
            if ([dic[key] isKindOfClass:[NSNumber class]]) {
                dic[key] = @0;
            }
        }
        if ([dic[key] isKindOfClass:[NSString class]] && [dic[key] isEqualToString:@"<null>"]) {
            dic[key] = @"";
            
        }
    }
    
    return dic;
}


@end
