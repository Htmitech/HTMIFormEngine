//
//  HTMIWorkFlowInputType521Strategy.m
//  MXClient
//
//  Created by wlq on 2018/1/26.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIWorkFlowInputType521Strategy.h"

#import "HTMIFieldItemModel.h"

#import "HTMITabFormModel.h"

#import "HTMIFormBaseView.h"

#import "HTMIFormComponentHeader.h"

#import "NSString+HTMISize.h"

#import "HTMIUserdefaultHelper.h"

#import "HTMIFormChangedFieldModel.h"

//#import "HTMIConst.h"

#import "HTMIFormTagView.h"

@implementation HTMIWorkFlowInputType521Strategy

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
    
    return [[HTMIFormTagView alloc] init];
}

/**
 获取字段view高度
 
 @return 字段view高度
 */
- (CGFloat)getFieldItemViewHeight {
    
    CGFloat allHeight = 0;

    CGFloat nameHeight = self.fieldItemModel.nameString.length>0 ? [NSString labelSizeWithMaxWidth:kScreenWidth-stringLeftWidth*2 content:self.fieldItemModel.nameString FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight*2 : 0;
    
    allHeight = [HTMIFormTagView formTagViewHeight:self.fieldItemModel] + nameHeight;
    
    return allHeight;
}

@end
