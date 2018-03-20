//
//  HTMIWorkFlowInputType3011Strategy.m
//  MXClient
//  读者作者相关
//  Created by wlq on 2018/1/26.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIWorkFlowInputType3011Strategy.h"

#import "HTMIFieldItemModel.h"

#import "HTMITabFormModel.h"

#import "HTMIFormBaseView.h"

#import "HTMIFormComponentHeader.h"

#import "NSString+HTMISize.h"

#import "HTMIUserdefaultHelper.h"

#import "HTMIFormChangedFieldModel.h"

//#import "HTMIConst.h"

#import "HTMIFormReaderView.h"

@implementation HTMIWorkFlowInputType3011Strategy

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert(NO,@"只能使用指定构造函数进行初始化initWithFieldItemModel:");
    }
    return self;
}

/**
 指定初始化方法
 
 @param fieldItemModel  字段模型
 @param tableItemModel  tab模型
 @return 策略对象
 */
- (instancetype)initWithFieldItemModel:(HTMIFieldItemModel *)fieldItemModel
                          tabFormModel:(HTMITabFormModel *)tabFormModel {
    
    self = [super initWithFieldItemModel:fieldItemModel tabFormModel:tabFormModel];
    if (self) {
        //子类的个性初始化
    }
    return self;
}

/**
 获取字段view
 
 @return 字段view
 */
- (HTMIFormBaseView *)getFieldItemView {
    
    return [[HTMIFormReaderView alloc] init];
}

/**
 获取字段view高度
 
 @return 字段view高度
 */
- (CGFloat)getFieldItemViewHeight {
    
    CGFloat allHeight = 0;
    
    if ([self.fieldItemModel.modeString isEqualToString:@"1"]) {//可编辑
        
        if (self.fieldItemModel.nameVisible) {
            
            if (self.fieldItemModel.nameRN) {//显示name且分行显示
                allHeight = self.nameHeight + MAX(self.valueHeight, kH6(40)) + borderTopHeight*2;
                
            } else {//显示name不分行
                allHeight = MAX(self.valueHeight, kH6(40)) + borderTopHeight*2;
            }
            
        } else {//不显示name
            allHeight = MAX(self.valueHeight, kH6(40)) + borderTopHeight*2;
        }
    } else {//不可编辑
        
        if (self.tabFormModel.tabStyle == 1 && self.fieldItemModel.scheduleFormNetWorkStyle) {
            
            allHeight = [self networkNoEditCellHeightWithItemWidth:self.fieldItemModel.finalItemWidth];
            
        } else {
            allHeight = [self inputNoEditHeightByFieldItemWithItemWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2];
        }
    }
    
    return allHeight;
}

@end
