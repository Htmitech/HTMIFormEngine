//
//  HTMIStandardTabItemModel.m
//  MXClient
//
//  Created by 赵志国 on 2017/10/16.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIStandardTabItemModel.h"

#import "MJExtension.h"

#import "HTMIStandardRegionModel.h"
#import "HTMIStandardTabEventModel.h"

@implementation HTMIStandardTabItemModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"regions" : @"HTMIStandardRegionModel"
             };
}

- (id)copyWithZone:(NSZone *)zone {
    HTMIStandardTabItemModel *model = [[[self class] allocWithZone:zone] init];
    
    model.tabId = [self.tabId copy];
    model.tabName = [self.tabName copy];
    
    model.tabType = self.tabType;
    model.tabContent = [self.tabContent copy];
    model.formKey = [self.formKey copy];
    
    model.flowId = [self.flowId copy];
    model.displayOrder = self.displayOrder;
    model.regions = [self.regions copy];
    model.tabEvent = [self.tabEvent copy];
    
    
    model.tabStyle = self.tabStyle;
    model.tabPurpose = self.tabPurpose;
    
    
    return model;
}
//
//+ (HTMIStandardTabItemModel *)getTabFormModelWithDict:(NSDictionary *)dict {
//
//    HTMIStandardTabItemModel *tabFormModel = [[HTMIStandardTabItemModel alloc] init];
//
//    tabFormModel.tabIdString = [dict objectForKey:@"TabID"];
//    tabFormModel.tabNameString = [dict objectForKey:@"TabName"];
//    tabFormModel.tabType = [[dict objectForKey:@"TabType"] integerValue];
//    tabFormModel.tabContentString = [dict objectForKey:@"TabContent"];
//    tabFormModel.formKeyString = [dict objectForKey:@"FormKey"];
//    tabFormModel.displayOrder = [[dict objectForKey:@"DisplayOrder"] integerValue];
//    tabFormModel.flowIdString = [dict objectForKey:@"FlowID"];
//    tabFormModel.regionCellArray = [dict objectForKey:@"Regions"];
//    tabFormModel.tabStyle = [[dict objectForKey:@"TabStyle"] integerValue];
//    tabFormModel.tabPurpose = [[dict objectForKey:@"TabPurpose"] integerValue];
//    tabFormModel.tabEventDict = [dict objectForKey:@"TabEvent"];
//
//    return tabFormModel;
//
//}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
