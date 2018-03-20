//
//  HTMIWorkFlowInputStrategy.m
//  MXClient
//
//  Created by wlq on 2018/1/26.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIWorkFlowInputTypeStrategy.h"

#import "HTMIFormBaseView.h"
#import "HTMITabFormModel.h"
#import "HTMIFieldItemModel.h"

#import "HTMIFormComponentHeader.h"
#import "NSString+HTMISize.h"
#import "HTMIUserdefaultHelper.h"
#import "HTMIFormChangedFieldModel.h"
//#import "HTMIConst.h"

@interface HTMIWorkFlowInputTypeStrategy()

/**
 字段模型
 */
@property (nonatomic, readwrite ,strong) HTMIFieldItemModel *fieldItemModel;

/**
 tab模型
 */
@property (nonatomic, readwrite ,strong) HTMITabFormModel *tabFormModel;

@end

@implementation HTMIWorkFlowInputTypeStrategy

/**
 指定初始化方法
 
 @param fieldItemModel  字段模型
 @param tableItemModel  tab模型
 @return 策略对象
 */
- (instancetype)initWithFieldItemModel:(HTMIFieldItemModel *)fieldItemModel
                          tabFormModel:(HTMITabFormModel *)tabFormModel
{
    self = [super init];
    if (self) {
        _fieldItemModel = fieldItemModel;
        _tabFormModel = tabFormModel;
    }
    return self;
}

/**
 获取字段view
 
 @param fieldItemModel 字段信息模型
 @param tableItemModel Tab信息模型
 @return 字段view
 */
- (HTMIFormBaseView *)getFieldItemView {
    
    return nil;
}

/**
 获取字段view高度
 
 @param fieldItemModel 字段信息模型
 @param tableItemModel Tab信息模型
 @return 字段view高度
 */
- (CGFloat)getFieldItemViewHeight  {
    
    return 0;
}

/**
 互联网表单不可编辑时的行高（日程管理时添加）
 
 @param itemWidth 字段宽度
 @return 互联网表单不可编辑时的行高
 */
- (CGFloat)networkNoEditCellHeightWithItemWidth:(CGFloat)itemWidth {
    CGFloat height = 0;
    
    CGFloat nameHeight = [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:self.fieldItemModel.finalNameString FontOfSize:self.fieldItemModel.formLabelFont].height;
    CGFloat valueHeight = [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:self.fieldItemModel.finalValueString FontOfSize:self.fieldItemModel.formLabelFont].height;
    
    if (self.fieldItemModel.finalNameString.length > 0) {
        height = nameHeight + valueHeight + stringTopHeight*2 + kH6(6);
    } else {
        height = valueHeight + stringTopHeight*2;
    }
    
    return height;
}

/**
 获取扩展字段不可编辑时的行高
 
 @param width 字段宽度
 @return 扩展字段不可编辑时的行高
 */
- (CGFloat)inputNoEditHeightByFieldItemWithItemWidth:(CGFloat)width {
    
    CGFloat height = 0;
    
    if (self.fieldItemModel.nameVisible) {
        
        height = [NSString labelSizeWithMaxWidth:width content:[NSString stringWithFormat:@"%@%@",self.fieldItemModel.finalNameString,self.fieldItemModel.finalValueString] FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight*2;
        
    } else {
        
        height = [NSString labelSizeWithMaxWidth:width content:self.fieldItemModel.finalValueString FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight*2;
    }
    
    return height;
}

- (CGFloat)havedOpinionsHeight:(NSArray *)opinions itemWidth:(CGFloat)itemWidth {
    CGFloat allHeight = 0;
    
    for (HTMIItemOpintionModel *model in opinions) {
        NSString *opinion = ((NSString *)model.opinionString).length>0 ? model.opinionString : @" ";
        NSString *name = model.userNameString;
        NSString *time = model.saveTimeString;
        
        CGFloat opinionHeight = [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:opinion FontOfSize:self.fieldItemModel.formLabelFont].height;
        CGFloat nameHeight = [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:name FontOfSize:self.fieldItemModel.formLabelFont].height;
        CGFloat timeHeight = [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:time FontOfSize:self.fieldItemModel.formLabelFont].height;
        
        CGFloat eachheight = opinionHeight + nameHeight + timeHeight + stringTopHeight;
        
        allHeight += eachheight;
    }
    
    return allHeight;
}


- (CGFloat)nameHeight {
    CGFloat nameHeight = self.fieldItemModel.finalNameString.length>0 ? [NSString labelSizeWithMaxWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2 content:self.fieldItemModel.finalNameString FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight*2 : 0;
    return nameHeight;
}

/**
 值高度
 */
- (CGFloat)valueHeight {
    CGFloat valueHeight = self.fieldItemModel.finalValueString.length>0 ? [NSString labelSizeWithMaxWidth:self.fieldItemModel.finalItemWidth-stringLeftWidth*2 content:self.fieldItemModel.finalValueString FontOfSize:self.fieldItemModel.formLabelFont].height+stringTopHeight*2 : 0;
    return valueHeight;
}

@end
