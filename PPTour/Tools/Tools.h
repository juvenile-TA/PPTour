//
//  Tools.h
//  
//
//  Created by wuxiang on 13-5-31.
//  Copyright (c) 2013年 wuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
//#import "NSDictionary+IsNull.h"
#define VALUEFORNSLOG 1
//#define NSLOG 0
#define MainBandle  [ UIScreen mainScreen].bounds
#define FRAME_WIDTH [UIScreen mainScreen].bounds.size.width
#define FRAME_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DRIVER_COUNT  ([UIscreen mainscreen].height>480?7:6)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//#if[[[UIDevice currentDevice] systemVersion] floatValue]<7.0
//#define FRAME_WIDTH [UIScreen mainScreen].bounds.size.height
//#else
//#define FRAME_WIDTH [UIScreen mainScreen].bounds.size.height
//#endif
//#define Init  float versions=[[[UIDevice currentDevice] systemVersion] floatValue];
//#define  VERSION   versions
//#define VERSIONSUPER   7
//#if     VERSION <VERSIONSUPER
//#define FRAME_HEIGHT [UIScreen mainScreen].bounds.size.height-20
//#else
//
//#endif


@interface Tools : NSObject
+(float)widthWithFontLenthUIlabel:(UILabel *)uilabel;
+(void)nsLogStart:(id)logValue andString:(NSString *)string;
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+ (float) heightForChineseString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+(NSString *)JSONString:(NSString *)aString;
+(float)viewHeight:(UIView *)viewmain;
+(NSString *)timescempTotime:(NSString *)timescemp;
+(UIColor*)stringRPGForUIColor:(NSString *)color;
+(NSString *)activitTimeFromStarTime:(NSString *)startTime EndTime:(NSString *)endTime;
+(NSString *)intervalSinceNow: (NSString *) theDate;
+ (NSString *)timerFireMethodWithTme:(NSString *)stattime;
+(BOOL)judgeTimeForNow:(NSString *)time;
//改变数据源数值 key 所需对比字段 value对比的值 array数据源 changekey需要改变的键 changeValue需要改变的值
+(NSMutableArray *)changeNetWorkDataWithKey:(NSString *)key
                                      value:(NSString *)value
                                netWorkData:(NSMutableArray *)array
                                  changeKey:(NSString *)changeKey
                                changeValue:(NSString *)changeValue;
+(BOOL)saveImage:(UIImage *)currentImage withName:(NSString *)fullPath;
+(BOOL)deleteImage:(NSString *)imagePath;
+(NSString *)makeImageName;
+(NSString *)readTimeChangeToTimescerm:(NSString *)time;
+(NSString *)activityTypeChangeToNum:(NSString *)name;

//删除数据流传过来的值中的标示符反斜杠
+(NSString *)strForJsonNormalFromServerJson:(NSString *)str;
//判断 数据流传过来的值是否为所需要的code值
+(BOOL)isRecevieStr:(NSString *)log;
//现在时间 2013-08-26 10:52:37
+(NSString *)dateNowToStr;
//数据库查询 数组转字符串   key = value , key = valuewhere id = XX
+(NSString *)dicChangeToStringForUpdate:(NSMutableDictionary *)dic;
//数据库查询 数组转字符串   key = value , key = value 
+(NSString *)dicChangeToStringForUpdateWithOtherField:(NSMutableDictionary *)dic;
//数据库查询 数组转字符串  where key = value
+(NSString *)dicChangeToStringForSelectWhere:(NSMutableDictionary *)dic;
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value key,key  value,value
+(NSMutableArray*)dictionryChangeToString:(NSMutableDictionary *)dic;
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value key,key  "value","value"
+(NSMutableArray*)dictionryChangeToInsertString:(NSMutableDictionary *)dic;
//数据库插入 字典转字符串 放在数组 array[0]=(string)keys array[1]=(string)value 并把Value中的双引号去除
+(NSMutableArray*)dictionryChangeToInsertStringAndChangeDoublePointToOnePoint:(NSMutableDictionary *)dic;
//数据库删除 数组转字符串   key = value AND key = value
+(NSString *)dicChangeToStringForDeleteWhere:(NSMutableDictionary *)dic;
//发送数据由字典转字符串    -无反斜杠
+(NSString *)sendDataWithDic:(NSDictionary *)datadic;
//发送数据由字典转字符串    -无反斜杠
+(NSString *)sendDataWithStr:(NSDictionary *)datadic;
//发送数据由数组转字符串    -无反斜杠 无data serviceCode
+(NSString *)sendDataWithDictonary:(NSDictionary *)dictionary;
+(void )subStringWithFirstAndLast:(NSMutableString *)str;
//获取时间数
+(NSArray *)chineseDateFormeters;
+(NSString *)getCurrentTime;
//双引号改单引号
+(NSString *)strDeleteDoubleTagWithStr:(NSString *)str;
//2013-09-05 15:25 现在时间
+(NSString *)strDateTimeForNow;
//2013-09-05 现在时间
+(NSString *)strDateForNow;
//发送数据由数组转字符串    -无反斜杠
+(NSString *)sendDataWithArray:(NSArray *)array;
// 字符串 04 转 int 4
+(int)strChangeToInt:(NSString *)str;
//正则表达式验证
+ (BOOL) regularUserInputText : (NSString *) str RegularString:(NSString *)regular;
/**
 *	@brief	浏览头像
 *
 *	@param 	oldImageView 	头像所在的imageView
 */
+(void)showImage:(UIImageView*)avatarImageView;
/**
 *	@brief	获取手机型号
 *
 *	@return	中文手机型号
 */
+ (NSString*)doDevicePlatform;
+(NSDictionary *)isNullWithDictionnary:(NSDictionary *)dic;
+(UIColor *) colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;
@end
