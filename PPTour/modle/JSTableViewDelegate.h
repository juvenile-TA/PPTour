//
//  JSTableViewDelegate.h
//  JSTableViewDelegateDemo
//
//  Created by JsWorkSpace on 14-10-29.
//  Copyright (c) 2014年 JS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark - self delegate
@protocol TableViewCellDelegate <NSObject>

@optional


/**
 *  删除cell时的代理方法
 *
 *  @param indexPath
 */
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  根据返回值判断该cell是否可以被操作(移动、删除、插入等)
 *
 *  @return YES:Can NO:Cant
 */
- (BOOL)isCellEditable;

/**
 *  返回Cell高度的代理方法
 *
 *  @param indexPath
 *
 *  @return
 */
- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath;

@end



#pragma mark - define block

/**
 *  配置UITableViewCell展现方式的block
 *
 *  @param cell UITableViewCell及其子类
 *  @param entity Cell对应的实体
 *  @param indexPath
 */
typedef void (^TableViewCellConfigurate)(id cell, id entity );

/**
 *  配置不同section中的cell的行数(rows)
 *
 *  @param section section下标
 *
 *  @return TableView中section的数量
 */
typedef int (^TableViewNumberOfRowsInSectionConfigurate) (NSInteger section);


/**
 *  点击事件
 */
typedef void (^TableViewDidSelectConfigurate)(NSIndexPath* indexPath);



#pragma mark - delegate.h


@interface JSTableViewDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic,strong) id<TableViewCellDelegate> delegate;
@property(nonatomic)CGFloat cellHeight;
@property (nonatomic,strong) NSArray                             *items;

-(id)initWithItems:(NSArray *)aItems
    cellIdentifier:(NSString *)aCellIdentifier
  numberOfSections:(NSInteger)aSectionNumber
numberOfRowsInSectionConfigureBlock:(TableViewNumberOfRowsInSectionConfigurate)aNunberOfRowsInSectionConfigureBlock
cellConfigureBlock:(TableViewCellConfigurate)aCellConfigureBlock
didSelectConfigure:(TableViewDidSelectConfigurate)aDidSelectConfigure;


@end
















