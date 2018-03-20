//
//  HTMIFormChangedFieldModel.m
//  MXClient
//
//  Created by wlq on 2017/8/28.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormChangedFieldModel.h"
#import "HTMIItemDicsModel.h"

@implementation HTMIFormChangedFieldModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"dics" : @"HTMIItemDicsModel"
             };
}

- (id)copyWithZone:(NSZone *)zone {

    HTMIFormChangedFieldModel * formChangedFieldModel = [[[self class] allocWithZone:zone ] init];

    formChangedFieldModel.fieldKey = [self.fieldKey copy];
    formChangedFieldModel.fieldValue = [self.fieldValue copy];
    formChangedFieldModel.dics = [self.dics copy];
    formChangedFieldModel.defaultDicIndex = [self.defaultDicIndex copy];
    formChangedFieldModel.hiden = self.hiden;
    formChangedFieldModel.editable = self.editable;

    return formChangedFieldModel;
}

@end

