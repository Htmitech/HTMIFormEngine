//
//  HTMIStandardRegionModel.m
//  MXClient
//
//  Created by wlq on 2017/01/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIStandardRegionModel.h"

#import "MJExtension.h"

@implementation HTMIStandardRegionModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"fieldItems" : @"HTMIStandardFieldItemModel"
             };
}

- (id)copyWithZone:(NSZone *)zone {
    HTMIStandardRegionModel *model = [[[self class] allocWithZone:zone] init];
    
    model.displayOrder = [self.displayOrder copy];
    model.vlineVisible = self.vlineVisible;
    model.regionId = [self.regionId copy];
    model.fieldItems = [self.fieldItems copy];
    model.isTable = self.isTable;
    model.tableId = [self.tableId copy];
    
    model.parentTableId = [self.parentTableId copy];
    model.splitAction = self.splitAction;
    model.backColor = self.backColor;
    model.isSplitRegion = self.isSplitRegion;
    
    model.parentRegionId = [self.parentRegionId copy];
    model.scrollFlag = self.scrollFlag;
    model.scrollFixColCount = self.scrollFixColCount;
    return model;
}

//+ (HTMIStandardRegionModel *)getRegionCellModelWithDict:(NSDictionary *)dict {
//
//    HTMIStandardRegionModel *regionCellModel = [[HTMIStandardRegionModel alloc] init];
//
//    regionCellModel.vlineVisible = [[dict objectForKey:@"VlineVisible"] boolValue];
//    regionCellModel.regionIdString = [dict objectForKey:@"RegionID"];
//    regionCellModel.regionNameString = [dict objectForKey:@"RegionName"];
//    regionCellModel.fieldItemArray = [dict objectForKey:@"FieldItems"];
//    regionCellModel.isTable = [[dict objectForKey:@"IsTable"] boolValue];
//    regionCellModel.tableIdString = [dict objectForKey:@"TableID"];
//    regionCellModel.parentTableIdString = [dict objectForKey:@"ParentTableID"];
//    regionCellModel.backColor = [[dict objectForKey:@"BackColor"] integerValue];
//    regionCellModel.isSplitRegion = [[dict objectForKey:@"IsSplitRegion"] boolValue];
//    regionCellModel.splitAction = [[dict objectForKey:@"SplitAction"] integerValue];
//    regionCellModel.parentRegionIdString = [dict objectForKey:@"ParentRegionID"];
//    regionCellModel.scrollFlag = [[dict objectForKey:@"ScrollFlag"] integerValue];
//    regionCellModel.scrollFixColCount = [[dict objectForKey:@"ScrollFixColCount"] integerValue];
//
//    return regionCellModel;
//
//}

//- (NSMutableDictionary *)allMaxWidthDic {
//    if (!_allMaxWidthDic) {
//        _allMaxWidthDic = [NSMutableDictionary dictionary];
//    }
//    return _allMaxWidthDic;
//}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
