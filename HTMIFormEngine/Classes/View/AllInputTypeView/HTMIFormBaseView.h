//
//  HTMIFormBaseView.h
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HTMIFormChangedFieldModel.h"

//#import "HTMIMatterFormModel.h"

@class HTMIFieldItemModel;

@class HTMITabFormModel;

@class HTMIFormBaseView;

@protocol HTMIFormBaseViewDelegate <NSObject>

- (void)editValueChangeKey:(NSString *)key
                     value:(NSString *)valueString
                      mode:(NSString *)mode
                 inputType:(NSString *)inputType
                   formKey:(NSString *)formKey
                     isExt:(BOOL)isExt
                 eventType:(NSString *)eventType
            fieldItemModel:(HTMIFieldItemModel *)fieldItemModel;

- (void)popViewDismiss;

- (void)setCurrentEidtRegionIndex:(NSInteger)currentEidtRegionIndex
        currentEidtFieldItemIndex:(NSInteger)currentEidtFieldItemIndex
                  infoRegionArray:(NSArray *)infoRegionArray;

//@required

/**
 意见

 @param opinion <#opinion description#>
 */
- (void)opinionViewClick:(NSString *)opinion;

/**
 选人或者选组织

 @param type <#type description#>
 @param fieldItem <#fieldItem description#>
 @param baseView <#baseView description#>
 */
- (void)selectNodeOrPeopleType:(NSInteger)type fieldItem:(HTMIFieldItemModel *)fieldItem baseView:(HTMIFormBaseView *)baseView;

/**
 定位

 @param fieldItem <#fieldItem description#>
 @param baseView <#baseView description#>
 */
- (void)mapSelectClickFieldItem:(HTMIFieldItemModel *)fieldItem baseView:(HTMIFormBaseView *)baseView;

@end

@interface HTMIFormBaseView : UIView

@property (nonatomic, weak) id<HTMIFormBaseViewDelegate> delegate;

@property (nonatomic, weak, readonly) HTMIFieldItemModel *fieldItemModel;

/**
 字体大小
 */
@property (nonatomic, assign, readonly) CGFloat formLabelFont;

@property (nonatomic, weak, readonly) UITableView *matterFormTableView;

@property (nonatomic, weak, readonly) NSArray *infoRegionArray;

@property (nonatomic, copy, readonly) NSString *nameString;

@property (nonatomic, copy, readonly) NSString *valueString;

/**
 item 宽
 */
@property (nonatomic, assign, readonly) CGFloat itemWidth;

/**
 行高
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

//@property (nonatomic, weak, readonly) UIView *parentView;

/**
 导航跳转用
 */
@property (nonatomic, weak, readonly) UIViewController *controller;

/**
 刷新 tableView 行
 */
@property (nonatomic, weak, readonly) NSIndexPath *indexPath;

/**
 table模型，这里用于判断 tab风格（表格式表单/互联网表单）
 */
@property (nonatomic, weak, readonly) HTMITabFormModel *tabFormModel;

@property (nonatomic, assign, readonly) BOOL scheduleFormNetWorkStyle;

- (void)setFieldItemModel:(HTMIFieldItemModel *)fieldItemModel
            formLabelFont:(CGFloat)formLabelFont
      matterFormTableView:(UITableView *)matterFormTableView
          infoRegionArray:(NSArray *)infoRegionArray
               nameString:(NSString *)nameString
              valueString:(NSString *)valueString
                itemWidth:(CGFloat)itemWidth
               cellHeight:(CGFloat)cellHeight
               controller:(UIViewController *)controller
                indexPath:(NSIndexPath *)indexPath
           tableItemModel:(HTMITabFormModel *)tableItemModel;


- (void)inputTypeFieldItem:(HTMIFieldItemModel *)fieldItem
                      name:(NSString *)nameString
                     value:(NSString *)valueString
                     width:(CGFloat)itemWidth
                 totalView:(UIView *)view
                cellHeight:(CGFloat)cellHeight;

/**
 处理Ajax事件 (需要子类实现)
 */
- (void)handleAjaxEvent:(HTMIFormChangedFieldModel *)changedFieldModel;



@end
