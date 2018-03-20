//
//  HTMIWorkFlowInputStrategy.h
//  MXClient
//
//  Created by wlq on 2018/1/26.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HTMIFormBaseView;
@class HTMIFieldItemModel;
@class HTMITabFormModel;

@interface HTMIWorkFlowInputTypeStrategy : NSObject

/**
 字段模型
 */
@property (nonatomic, readonly ,strong) HTMIFieldItemModel *fieldItemModel;

/**
 tab模型
 */
@property (nonatomic, readonly ,strong) HTMITabFormModel *tabFormModel;

/**
 名称高度
 */
@property (nonatomic, assign) CGFloat nameHeight;

/**
 值高度
 */
@property (nonatomic, assign) CGFloat valueHeight;

/**
 指定初始化方法
 
 @param fieldItemModel  字段模型
 @param tableItemModel  tab模型
 @return 策略对象
 */
- (instancetype)initWithFieldItemModel:(HTMIFieldItemModel *)fieldItemModel
                          tabFormModel:(HTMITabFormModel *)tabFormModel;

/**
 获取字段view
 
 @return 字段view
 */
- (HTMIFormBaseView *)getFieldItemView;

/**
 获取字段view高度
 
 @return 字段view高度
 */
- (CGFloat)getFieldItemViewHeight;

/**
 互联网表单不可编辑时的行高（日程管理时添加）
 
 @param itemWidth 字段宽度
 @return 互联网表单不可编辑时的行高
 */
- (CGFloat)networkNoEditCellHeightWithItemWidth:(CGFloat)itemWidth;

/**
 获取扩展字段不可编辑时的行高
 
 @param width 字段宽度
 @return 扩展字段不可编辑时的行高
 */
- (CGFloat)inputNoEditHeightByFieldItemWithItemWidth:(CGFloat)width;

- (CGFloat)havedOpinionsHeight:(NSArray *)opinions itemWidth:(CGFloat)itemWidth;

@end
