//
//  HTMIStandardFieldItemModel.m
//  MXClient
//
//  Created by wlq on 2017/01/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIStandardFieldItemModel.h"

#import "HTMIStandardAjaxEventModel.h"

#import "MJExtension.h"

@implementation HTMIStandardFieldItemModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"signs" : @"HTMIStandardSignModel",
             @"opintions" : @"HTMIStandardOpintionModel",
             @"dics" : @"HTMIStandardDicModel",
             @"filedImages" : @"HTMIStandardFiledFileModel",
             @"filedAudios" : @"HTMIStandardFiledFileModel",
             @"filedVideos" : @"HTMIStandardFiledFileModel"
             };
}

- (id)copyWithZone:(NSZone *)zone {
    
    HTMIStandardFieldItemModel *model = [[[self class] allocWithZone:zone] init];
    model.name = [self.name copy];
    model.nameVisible = self.nameVisible;
    model.splitString = [self.splitString copy];
    model.nameRN = self.nameRN;
    model.value = [self.value copy];
    model.beforeValueString = [self.beforeValueString copy];
    model.endValueString = [self.endValueString copy];
    model.percent = self.percent;
    model.displayOrder = [self.displayOrder copy];
    model.align = [self.align copy];
    model.key = [self.key copy];
    model.mode = [self.mode copy];
    model.input = [self.input copy];
    model.maxLength = self.maxLength;
    model.mustInput = self.mustInput;
    model.opintions = [self.opintions copy];
    model.dics = [self.dics copy];
    model.isSplitWithLine = self.isSplitWithLine;
    model.backColor = self.backColor;
    model.nameFontColor = self.nameFontColor;
    model.valueFontColor = self.valueFontColor;
    model.fieldId = [self.fieldId copy];
    model.formKey = [self.formKey copy];
    model.filedImages = [self.filedImages copy];
    model.filedAudios = [self.filedAudios copy];
    model.filedVideos = [self.filedVideos copy];
    model.isExt = self.isExt;
    model.ajaxEvent = [self.ajaxEvent copy];
    
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
