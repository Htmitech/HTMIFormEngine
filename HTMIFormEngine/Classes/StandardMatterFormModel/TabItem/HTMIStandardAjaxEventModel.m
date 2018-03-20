//
//  HTMIStandardAjaxEventModel.m
//  MXClient
//
//  Created by wlq on 2018/1/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIStandardAjaxEventModel.h"

#import "MJExtension.h"

@implementation HTMIStandardAjaxEventModel

- (id)copyWithZone:(NSZone *)zone {
    
    HTMIStandardAjaxEventModel *model = [[self class] allocWithZone:zone];
    
    model.eventType = [self.eventType copy];
    model.eventApi = [self.eventApi copy];
    
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
