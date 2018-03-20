//
//  HTMIStandardMatterFormModel.m
//  MXClient
//
//  Created by wlq on 2018/01/23.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIStandardMatterFormModel.h"

#import "HTMIStandardTabItemModel.h"
#import "HTMIStandardActionModel.h"
#import "HTMIStandardAttachModel.h"
#import "HTMIStandardTrackInfoModel.h"

#import "MJExtension.h"

@implementation HTMIStandardMatterFormModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"tabItems" : @"HTMIStandardTabItemModel",
             @"listActionInfo" : @"HTMIStandardActionModel",
             @"listAttInfo" : @"HTMIStandardAttachModel",
             @"listTrackInfo" : @"HTMIStandardTrackInfoModel"
             };
}

- (id)copyWithZone:(NSZone *)zone {
    HTMIStandardMatterFormModel *model = [[[self class] allocWithZone:zone] init];
    
    model.docId = [self.docId copy];
    model.formId = [self.formId copy];
    model.dataId = [self.dataId copy];
    
    model.tabItems = [self.tabItems copy];
    model.listActionInfo = [self.listActionInfo copy];
    model.listAttInfo = [self.listAttInfo copy];
    model.listTrackInfo = [self.listTrackInfo copy];
    
    model.docAttachmentId = [self.docAttachmentId copy];
    model.flowId = [self.flowId copy];
    model.flowName = [self.flowName copy];
    model.currentNodeId = [self.currentNodeId copy];
    model.currentNodeName = [self.currentNodeName copy];
    model.currentUserId = [self.currentUserId copy];
    model.currentUsername = [self.currentUsername copy];//currentUserName
    model.currentTrackId = [self.currentTrackId copy];
    model.systemCode = [self.systemCode copy];
    
    return model;
}


- (NSString *)description {
    return [self mj_keyValues].description; 
}

@end
