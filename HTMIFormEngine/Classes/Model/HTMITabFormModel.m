//
//  HTMITabFormModel.m
//  MXClient
//
//  Created by 赵志国 on 2017/10/16.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMITabFormModel.h"
#import "HTMIStandardTabItemModel.h"
#import "HTMIStandardTabEventModel.h"

#import "MJExtension.h"

@implementation HTMITabFormModel

/**
 使用标准表单模型初始化表单模型
 
 @param standardTabItemModel 标准表单模型
 @return 表单模型
 */
- (instancetype)initWithStandardTabItemModel:(HTMIStandardTabItemModel *)standardTabItemModel
{
    self = [super init];
    if (self) {
        _tabIdString = standardTabItemModel.tabId;
        _tabNameString = standardTabItemModel.tabName;
        _tabType = standardTabItemModel.tabType;
        _tabContentString = standardTabItemModel.tabContent;
        _formKeyString = standardTabItemModel.formKey;
        _displayOrder = standardTabItemModel.displayOrder;
        _flowIdString = standardTabItemModel.flowId;
        _tabStyle = standardTabItemModel.tabStyle;
        _tabPurpose = standardTabItemModel.tabPurpose;
        
        _tabEventModel = standardTabItemModel.tabEvent;
        
        if (standardTabItemModel.tabType == 1) {//只处理原生渲染样式
            [self setRegionCellArrayWithStandardRegionModelArray:standardTabItemModel.regions];
        }
    }
    return self;
}

/**
 通过标准区域数据模型数组设置区域模型数组
 
 @param standardRegionModelArray 标准区域数据模型数组
 */
- (void)setRegionCellArrayWithStandardRegionModelArray:(NSArray<HTMIStandardRegionModel *> *)standardRegionModelArray {
    
    NSMutableArray *regionCellModelArray = [NSMutableArray array];
    
    //子表折叠
    NSMutableArray *childFormReginArray = [NSMutableArray array];
    
    //当前表单的所有区域的事件key value
    NSMutableArray *eventKeyValueArray = [NSMutableArray array];
    
    [standardRegionModelArray enumerateObjectsUsingBlock:^(HTMIStandardRegionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HTMIRegionCellModel *regionCellModel = [[HTMIRegionCellModel alloc] initWithStandardRegionModel:obj];
        [regionCellModelArray addObject:regionCellModel];
        
        [eventKeyValueArray addObjectsFromArray:regionCellModel.eventKeyValueArray];
        
        /**
         *  折叠子表
         */
        //NSMutableDictionary *childForms = [NSMutableDictionary dictionary];
        
        if (regionCellModel.parentRegionIdString.length > 0) {
            //[childForms setObject:regionCellModel.regionIdString forKey:regionCellModel.parentRegionIdString];
            
            [childFormReginArray addObject:regionCellModel];
        }
    }];
    
    _regionCellArray = regionCellModelArray;
    _childTabFormMarray = childFormReginArray;//子表折叠行    默认折叠
    _eventKeyValueArray = eventKeyValueArray;
}

- (id)copyWithZone:(NSZone *)zone {
    HTMITabFormModel *model = [[[self class] allocWithZone:zone] init];
    
    model.tabIdString = [self.tabIdString copy];
    model.tabNameString = [self.tabNameString copy];
    model.tabContentString = [self.tabContentString copy];
    model.formKeyString = [self.formKeyString copy];
    model.flowIdString = [self.flowIdString copy];
    model.regionCellArray = [self.regionCellArray copy];
    model.tabEventModel = [self.tabEventModel copy];
   
    model.tabType = self.tabType;
    model.displayOrder = self.displayOrder;
    model.tabStyle = self.tabStyle;
    model.tabPurpose = self.tabPurpose;

    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
