//
//  HTMIFormFieldItemStrategy.h
//  MXClient
//
//  Created by wlq on 2017/8/31.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@class HTMIFormBaseView;
@class HTMIFieldItemModel;
@class HTMITabFormModel;

@interface HTMIFormFieldItemContext : NSObject

- (instancetype)initWithFormFieldItemModel:(HTMIFieldItemModel *)formFieldItemModel;

/**
 根据输入类型获取字段View
 
 @param inputType 字段输入类型
 @return 字段View
 */
- (HTMIFormBaseView *)getFieldItemView:(NSString *)inputType;


/**
 获取字段view高度
 
 @param inputType 输入类型
 @param fontSize 字体大小
 @param tableItemModel item模型
 @return 字段view高度
 */
- (CGFloat)getFieldItemViewHeight:(NSString *)inputType
                         fontSize:(CGFloat)fontSize
                   tableItemModel:(HTMITabFormModel *)tableItemModel;

@end
