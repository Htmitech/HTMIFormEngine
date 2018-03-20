//
//  HTMIRegionCellModel.m
//  MXClient
//
//  Created by 赵志国 on 2017/10/16.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIRegionCellModel.h"

#import "HTMIStandardRegionModel.h"

#import "HTMIStandardFieldItemModel.h"

#import "HTMIFormFieldItemContext.h"
#import "HTMIFormComponentHeader.h"
#import "HTMIWorkFlowEventKeyValueModel.h"
#import "UIColor+Hex.h"

#import "MJExtension.h"

@implementation HTMIRegionCellModel

/**
 指定模型初始化
 
 @param standardRegionModel 标准区域模型
 @return 区域模型
 */
- (instancetype)initWithStandardRegionModel:(HTMIStandardRegionModel *)standardRegionModel
{
    self = [super init];
    if (self) {
        
        _vlineVisible = standardRegionModel.vlineVisible;
        _regionIdString = standardRegionModel.regionId;
        _isTable = standardRegionModel.isTable;
        _tableIdString = standardRegionModel.tableId;
        _parentTableIdString = standardRegionModel.parentTableId;
        _backColor = standardRegionModel.backColor;
        _isSplitRegion = standardRegionModel.isSplitRegion;
        _splitAction = standardRegionModel.splitAction;
        _parentRegionIdString = standardRegionModel.parentRegionId;
        _scrollFlag = standardRegionModel.scrollFlag;
        _scrollFixColCount = standardRegionModel.scrollFixColCount;
        
        //        /**
        //         *  开始滑动标记，每个滑动区域开始滑动时初始化
        //         */
        //        if (standardRegionModel.isSplitRegion &&
        //            standardRegionModel.parentRegionId.length < 1 &&
        //            standardRegionModel.scrollFlag == 1) {
        //
        //            _eachMaxWidthArray = [NSMutableArray array];
        //        }
        
        [self setFieldItemArrayWithStandardFieldItemModelArray:standardRegionModel.fieldItems];
        
        //        if (_eachMaxWidthArray != nil && _eachMaxWidthArray.count > 0) {
        //            [_allMaxWidthDic setObject:_eachMaxWidthArray forKey:_parentRegionIdString];
        //        }
        
    }
    return self;
}

/**
 通过标准的字段模型数组初始化字段模型数组
 
 @param standardFieldItemModelArray 标准的字段模型数组
 */
- (void)setFieldItemArrayWithStandardFieldItemModelArray:(NSArray<HTMIStandardFieldItemModel *> *)standardFieldItemModelArray {
    
    NSMutableArray *fieldItemModelArray = [NSMutableArray array];
    //当前行的所有事件keyvalue
    NSMutableArray *eventKeyValueArray = [NSMutableArray array];
    [standardFieldItemModelArray enumerateObjectsUsingBlock:^(HTMIStandardFieldItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HTMIFieldItemModel *fieldItemModel = [[HTMIFieldItemModel alloc] initWithStandardFieldItemModel:obj];
        
        [fieldItemModelArray addObject:fieldItemModel];
        
        /**
         * 所有不为空的其他字段值合集(add 2.5.5 表单事件)
         */
        if (fieldItemModel.valueString.length > 0 && fieldItemModel.keyString.length > 0) {
            HTMIWorkFlowEventKeyValueModel * eventKeyValueModel = [[HTMIWorkFlowEventKeyValueModel alloc] initWithFieldKey:fieldItemModel.keyString fieldValue:fieldItemModel.valueString];
            [eventKeyValueArray addObject:eventKeyValueModel];
        }
        
        //        //初始化最大宽度
        //        if (_scrollFlag == 1 && _parentRegionIdString.length > 0) {
        //
        //            if (_eachMaxWidthArray.count < _fieldItemArray.count) {
        //
        //                CGFloat percent = fieldItemModel.percent / 100.f;
        //                CGFloat itemWidth = kScreenWidth * percent;
        //                [_eachMaxWidthArray addObject:[NSString stringWithFormat:@"%f",itemWidth]];
        //            }
        //        }
        
        
    }];
    
    
    _eventKeyValueArray = eventKeyValueArray;
    _fieldItemArray = fieldItemModelArray;
}

- (id)copyWithZone:(NSZone *)zone {
    HTMIRegionCellModel *model = [[[self class] allocWithZone:zone] init];
    
    model.regionIdString = [self.regionIdString copy];
    model.fieldItemArray = [self.fieldItemArray copy];
    model.tableIdString = [self.tableIdString copy];
    model.parentTableIdString = [self.parentTableIdString copy];
    model.parentRegionIdString = [self.parentRegionIdString copy];
    model.vlineVisible = self.vlineVisible;
    model.isTable = self.isTable;
    model.backColor = self.backColor;
    model.isSplitRegion = self.isSplitRegion;
    model.splitAction = self.splitAction;
    model.scrollFlag = self.scrollFlag;
    model.scrollFixColCount = self.scrollFixColCount;
    model.isOpen = self.isOpen;
    
    model.vlineVisible = self.vlineVisible;
    model.isTable = self.isTable;
    model.backColor = self.backColor;
    model.isSplitRegion = self.isSplitRegion;
    model.splitAction = self.splitAction;
    model.scrollFlag = self.scrollFlag;
    model.scrollFixColCount = self.scrollFixColCount;
    model.isOpen = self.isOpen;
    
    return model;
}

//- (NSMutableDictionary *)allMaxWidthDic {
//    if (!_allMaxWidthDic) {
//        _allMaxWidthDic = [NSMutableDictionary dictionary];
//    }
//    return _allMaxWidthDic;
//}

/**
 从模型获取cell高度

 @param tabFormModel 页签模型
 @param formLabelFont 表单整体字体
 @return 模型对应的cell高度
 */
- (CGFloat)tableViewCellHeightByTabFormModel:(HTMITabFormModel *)tabFormModel
                               formLabelFont:(NSInteger)formLabelFont {
    
    CGFloat maxAllContentHeight = 0.f;
        
    NSArray *itemListInLine = self.fieldItemArray;
    
    for (int i = 0; i < itemListInLine.count; i++) {
        HTMIFieldItemModel *fieldItem = itemListInLine[i];
        
        CGFloat itemWidth = kScreenWidth * (fieldItem.percent / 100.f);
        
        //拼接好的字段名称
        NSString *nameString = [NSString stringWithFormat:@"%@%@%@%@", fieldItem.beforeNameString, fieldItem.nameString, fieldItem.endNameString, fieldItem.splitString];
        
        //拼接好的值
        NSString *valueString = [NSString stringWithFormat:@"%@%@%@", fieldItem.beforeValueString, fieldItem.valueString, fieldItem.endValueString];
        
        HTMIFormFieldItemContext *formFieldItemStrategy = [[HTMIFormFieldItemContext alloc] initWithFormFieldItemModel:fieldItem];
        
        //获取每个item的高度，然后取最大值
        CGFloat itemHeight = [formFieldItemStrategy getFieldItemViewHeight:fieldItem.inputString fontSize:formLabelFont tableItemModel:tabFormModel];
        
        if (itemHeight > maxAllContentHeight) {
            maxAllContentHeight = itemHeight;
        }
    }
    
    //设定最低高度为
    CGFloat minHeight = cellMinHeight;
    
    if (!IS_IPHONE_6P) {
        if (formLabelFont == 13) {
            minHeight = kH6(40);
        }
    }
    
    if (self.scrollFlag == 1) {
        return cellMinHeight;
    }
    
    if (self.isSplitRegion && self.splitAction == 0) {
        //分割部分
        return 20;
    } else {
        return MAX(minHeight, maxAllContentHeight);
    }
    return 0;
}

//实际给外面使用的
- (UIColor *)backColorForCell {
    if (!_backColorForCell) {
        NSString *colorString = [NSString stringWithFormat:@"%lx",(long)self.backColor];
        UIColor *cellColor = [UIColor colorWithHex:colorString
                                             alpha:self.waterMarkAlpha
                                           isWhite:self.tabStyle];
        _backColorForCell = nil;
    }
   return _backColorForCell;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
