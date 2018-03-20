//
//  HTMIWorkFlowInputType201Strategy.h
//  MXClient
//
//  Created by wlq on 2018/1/26.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTMIWorkFlowInputTypeStrategy.h"

@interface HTMIWorkFlowInputType201Strategy : HTMIWorkFlowInputTypeStrategy

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

@end
