//
//  HTMIWorkFlowInputTypeDefaultStrategy.m
//  MXClient
//  
//  Created by wlq on 2018/1/26.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIWorkFlowInputTypeDefaultStrategy.h"

#import "HTMIFieldItemModel.h"

#import "HTMITabFormModel.h"

#import "HTMIFormBaseView.h"

#import "HTMIFormComponentHeader.h"

#import "NSString+HTMISize.h"

#import "HTMIUserdefaultHelper.h"

#import "HTMIFormChangedFieldModel.h"

//#import "HTMIConst.h"


@implementation HTMIWorkFlowInputTypeDefaultStrategy

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
    
    return nil;
}

/**
 获取字段view高度
 
 @return 字段view高度
 */
- (CGFloat)getFieldItemViewHeight {
    
    CGFloat allHeight = 0;
    
    if (self.tabFormModel.tabStyle == 1 && self.fieldItemModel.scheduleFormNetWorkStyle) {
        
        allHeight = [self networkNoEditCellHeightWithItemWidth:self.fieldItemModel.finalItemWidth];
        
    } else {
        if (self.fieldItemModel.nameVisible) {
            allHeight = [NSString labelSizeWithMaxWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2 content:[NSString stringWithFormat:@"%@%@",self.fieldItemModel.finalNameString,self.fieldItemModel.finalValueString] FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight*2;
            
        } else {
            allHeight = [NSString labelSizeWithMaxWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2 content:self.fieldItemModel.finalValueString FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight*2;
        }
    }
    
    return allHeight;
}

@end
