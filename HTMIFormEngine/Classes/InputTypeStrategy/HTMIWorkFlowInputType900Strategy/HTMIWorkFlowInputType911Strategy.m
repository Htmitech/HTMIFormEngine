//
//  HTMIWorkFlowInputType911Strategy.m
//  MXClient
//
//  Created by wlq on 2018/1/26.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIWorkFlowInputType911Strategy.h"

#import "HTMIFieldItemModel.h"

#import "HTMITabFormModel.h"

#import "HTMIFormBaseView.h"

#import "HTMIFormComponentHeader.h"

#import "NSString+HTMISize.h"

#import "HTMIUserdefaultHelper.h"

#import "HTMIFormChangedFieldModel.h"

//#import "HTMIConst.h"

#import "HTMIFormSelectNodeView.h"

@implementation HTMIWorkFlowInputType911Strategy

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
    
    return [[HTMIFormSelectNodeView alloc] init];
}

/**
 获取字段view高度
 
 @return 字段view高度
 */
- (CGFloat)getFieldItemViewHeight {
    
    CGFloat allHeight = 0;
    
    CGFloat nameHeight = self.fieldItemModel.finalNameString.length>0 ? [NSString labelSizeWithMaxWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2 content:self.fieldItemModel.finalNameString FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight*2 : 0;
    CGFloat valueHeight = self.fieldItemModel.finalValueString.length>0 ? [NSString labelSizeWithMaxWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2 content:self.fieldItemModel.finalValueString FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight*2 : 0;
    
    if ((![self.fieldItemModel.modeString isEqual:[NSNull null]] && [self.fieldItemModel.modeString isEqualToString:@"1"])) {
        if (self.fieldItemModel.nameVisible) {
            if (self.fieldItemModel.nameRN) {//显示name且分行显示
                allHeight = nameHeight + MAX(valueHeight, kH6(40)) + borderTopHeight*2;
                
            } else {//显示name不分行
                allHeight = MAX(valueHeight, kH6(40)) + borderTopHeight*2;
            }
        } else {//不显示name
            allHeight = MAX(valueHeight, kH6(40)) + borderTopHeight*2;
        }
    } else {
        
        if (self.tabFormModel.tabStyle == 1 && self.fieldItemModel.scheduleFormNetWorkStyle) {
            
            allHeight = [self networkNoEditCellHeightWithItemWidth:self.fieldItemModel.finalItemWidth];
            
        } else {
            allHeight = [self inputNoEditHeightByFieldItemWithItemWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2];
        }
        
    }
    return allHeight;
}

@end

