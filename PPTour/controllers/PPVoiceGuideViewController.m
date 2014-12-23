//
//  PPVoiceGuideViewController.m
//  PPTour
//
//  Created by g5-1 on 14/11/13.
//  Copyright (c) 2014年 g5-1. All rights reserved.
//

#import "PPVoiceGuideViewController.h"
#import "PPPointViewController.h"
#import "SBJsonParser.h"
#import "PPPointListViewController.h"
@interface PPVoiceGuideViewController ()
@property (strong, nonatomic) IBOutlet UIView *mapView;
@property (nonatomic, strong) UIScrollView *mapScrollView;
@property (nonatomic, strong) UIImageView *mapImageView;
@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (strong,nonatomic) UIButton *roadButton;
@property (strong,nonatomic) NSString *requestTag;
@property (strong,nonatomic) NSArray *roadArray;
@property (strong,nonatomic) UIView *infoView;
@property (strong,nonatomic) UIView *grayBackView;
@property (strong,nonatomic) UITableView *roadTableView;
@end

@implementation PPVoiceGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.buttonArray = [NSMutableArray array];

    self.requstClient = [[NetworkRequest alloc] initWithDelegate:self];
    [self.requstClient requestDataFromServerWithInfo:@{@"data":@"XX,XX|0,70",@"serviceCode":@"com.ggo.http.service.mobile.HttpService,findAllPage_STN"}];
    [self HUDshowWithStatus:@"正在加载..."];
    self.requestTag=@"point";
    
    CGRect rect = self.mapView.frame;
    self.mapScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    self.mapScrollView.contentSize = CGSizeMake(1358/2, 1358/2);
    self.mapScrollView.minimumZoomScale = 1.0f;
    self.mapScrollView.maximumZoomScale = 3.0f;
    self.mapScrollView.delegate = self;
    
    self.mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1358/2, 1358/2)];
    self.mapImageView.image = [UIImage imageNamed:@"map.png"];
    self.mapImageView.userInteractionEnabled = YES;
    
    self.mapScrollView.contentOffset = CGPointMake((1385 / 2 - 320) / 2, 0);
    [self.mapScrollView addSubview:self.mapImageView];
    
    self.mapScrollView.contentOffset = CGPointMake((1358/2 - 320) / 2, 0);
    
    [self.mapView addSubview:self.mapScrollView];
    
    self.roadButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.roadButton addTarget:self action:@selector(clickToRoadLine) forControlEvents:UIControlEventTouchUpInside];
    self.roadButton.frame=CGRectMake(250, FRAME_HEIGHT-70, 40, 50);
    [self.roadButton setBackgroundImage:[UIImage imageNamed:@"lu"] forState:UIControlStateNormal];
    [self.view addSubview:self.roadButton];
    
    [self playMusic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)playMusic {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    _areaPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_areaPlayer prepareToPlay];
    [_areaPlayer play];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_areaPlayer stop];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView ==  self.mapScrollView) {
        return self.mapImageView;
    }
    return nil;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    if (scrollView ==  self.mapScrollView) {
        UIButton *button = nil;
        float scale = 0.f;
        for (int i = 0; i < self.buttonArray.count; ++i) {
            button = self.buttonArray[i];
            CGRect rect = button.frame;
            if (scrollView.zoomScale < 1.0) {
                scale = 1.0f;
            }else{
                scale = scrollView.zoomScale;
            }
            button.frame = CGRectMake(rect.origin.x , rect.origin.y,25/scale,25/scale);
        }
    }
    
}
- (void)createButtons{
    if ([self.buttonArray count]>0) {
        for (UIButton *button in self.buttonArray) {
            [button removeFromSuperview];
        }
        self.buttonArray=[NSMutableArray array];
    }
    
    for (int i = 0; i < self.infoArray.count; ++ i) {
        
        NSDictionary *palaceInfo = self.infoArray[i];
        NSDictionary *point= [self adjustPointToDiction:palaceInfo];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake([point[@"lefts"] floatValue],[point[@"tops"] floatValue], 25, 25)];
        [button setImage:[UIImage imageNamed:@"show_detail_normal.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"show_detail_press.png"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(palaceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.mapImageView addSubview:button];
        [self.buttonArray addObject:button];
    }
}
-(NSDictionary *)adjustPointToDiction:(NSDictionary *)palaceInfo
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSString  *left=[NSString stringWithFormat:@"%f",[palaceInfo[@"lefts"] floatValue] * 7.85];
    NSString  *tops=[NSString stringWithFormat:@"%f",[palaceInfo[@"tops"] floatValue] * 7.85];
    [dic setObject:left forKey:@"lefts"];
    [dic setObject:tops forKey:@"tops"];
    // NSLog(@"palaceInfo %@",palaceInfo);
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"体和殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -4];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -20];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"储秀宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +18];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -15];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"翊坤宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +17];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -24];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"咸福宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +21];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -18];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"长春宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +24];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -25];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"太极殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +22];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -29];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"永寿宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +16];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -29];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"养心殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +18];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -29];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"千秋亭"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +10];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -18];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"延晖阁"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +4];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -15];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"御景亭"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +8];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -15];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"堆秀山"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -16];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -13];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"神武门"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +3];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] +5];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"万春亭"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -3];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -18];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"钦安殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +5];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -20];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"御花园"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +5];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -20];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"绛雪轩"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +23];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -22];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"坤宁门"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +15];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -24];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"坤宁宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +5];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -26];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"交泰殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +5];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -26];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"乾清宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +5];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -26];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"乾清门"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +3];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -32];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"钟粹宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -4];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -18];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"景阳宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -10];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -16];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"承乾宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -5];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -18];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"景仁宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -6];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -24];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"永和宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -12];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -18];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"延禧宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -12];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -24];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"颐和轩"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -27];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -20];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"乐寿堂"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -25];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -25];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"畅音阁"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -30];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -20];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"斋宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -5];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -32];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"奉先殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -15];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -32];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"宁寿宫"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -27];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -25];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"皇极殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -27];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -35];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"九龙壁"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -23];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -45];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"保和殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +0];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -30];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"中和殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +2];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -40];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"太和殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +4];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -55];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"隆宗门"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +12];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -34];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"弘义阁"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +15];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -44];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"武英殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +27];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -60];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"太和门"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +3];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -45];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"午门"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] +8];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -65];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    if ([[palaceInfo objectForKey:@"note"] isEqualToString:@"文华殿"]) {
        NSString  *lefts=[NSString stringWithFormat:@"%f",[dic[@"lefts"] floatValue] -15];
        NSString  *tops=[NSString stringWithFormat:@"%f",[dic[@"tops"] floatValue] -65];
        [dic setObject:lefts forKey:@"lefts"];
        [dic setObject:tops forKey:@"tops"];
    }
    return dic;
}
-(void)palaceButtonClicked:(UIButton *)button{
    NSDictionary *palaceInfo = self.infoArray[button.tag];
    PPPointViewController * point = [self.storyboard instantiateViewControllerWithIdentifier:@"Point"];
    point.palaceInfo = palaceInfo;
    [self.navigationController pushViewController:point animated:YES];
}
#pragma mark - Network Call Back
- (void)requestSuccessWithInfo:(id)info{
    if ([self.requestTag isEqualToString:@"point"]) {
        
        NSDictionary *infoDic = (NSDictionary *)info;
        
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        self.infoArray = [jsonParser objectWithString:infoDic[@"totalRoot"]];
        [self createButtons];
        [self.requstClient requestDataFromServerWithInfo:@{@"data":@"XX",@"serviceCode":@"com.ggo.http.service.mobile.HttpService,findList_LABLE"}];
        self.requestTag=@"luxian";
    }else if ([self.requestTag isEqualToString:@"luxian"]) {
        self.roadArray = info;
        [self dismissProgressView];
        
    }else if ([self.requestTag isEqualToString:@"repeat"]){
        NSDictionary *infoDic = (NSDictionary *)info;
        
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        self.infoArray = [jsonParser objectWithString:infoDic[@"totalRoot"]];
        [self createButtons];
        [self dismissProgressView];
    }
    
    
    
}

- (void)requestFailWithError:(NSError *)error{
    [self HUDshowErrorWithStatus:error.description];
}

-(void)clickToRoadLine
{
    [self showInfoView];
}
-(void)showInfoView
{
    self.grayBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, FRAME_WIDTH, FRAME_HEIGHT)];
    self.grayBackView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:self.grayBackView];
    UITapGestureRecognizer *tapToCloseView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickToCloseView)];
    [self.grayBackView addGestureRecognizer:tapToCloseView];
    
    
    self.infoView=[[UIView alloc]initWithFrame:CGRectMake(150, 250, 170, FRAME_HEIGHT-330)];
    self.infoView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:self.infoView];
    
    self.roadTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.infoView.frame.size.width, self.infoView.frame.size.height)];
    self.roadTableView.delegate=self;
    self.roadTableView.dataSource=self;
    self.roadTableView.backgroundColor=[UIColor clearColor];
    [self.infoView addSubview:self.roadTableView];
    
    
}
-(void)clickToCloseView
{
    [self.grayBackView removeFromSuperview];
    [self.infoView removeFromSuperview];
    [self.roadTableView removeFromSuperview];
    self.grayBackView=nil;
    self.infoView=nil;
    self.roadTableView=nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.roadArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row=indexPath.row;
    static NSString *CellAdsOrder = @"CellAdsOrderInden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellAdsOrder];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellAdsOrder];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    }
    cell.textLabel.text=[[self.roadArray objectAtIndex:row] objectForKey:@"lvalcname"];
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.requestTag=@"repeat";
    int row=indexPath.row;
    NSDictionary *data=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@,XX|0,70",[[self.roadArray objectAtIndex:row] objectForKey:@"lvalename"] ],@"data",@"com.ggo.http.service.mobile.HttpService,findAllPage_STN",@"serviceCode", nil];
    [self.requstClient requestDataFromServerWithInfo:data];
    [self HUDshowWithStatus:@"正在加载..."];
    [self clickToCloseView];
}
//- (IBAction)clickToPointList:(id)sender {
//    PPPointListViewController *pointList = [self.storyboard instantiateViewControllerWithIdentifier:@"PointList"];
//    pointList.pointArray=[NSMutableArray arrayWithArray:self.infoArray];
//    [self.navigationController pushViewController:pointList animated:YES];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
