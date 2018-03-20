//
//  HTMIStandardActionModel.m
//  MXClient
//
//  Created by wlq on 2018/01/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIStandardActionModel.h"
#import "HTMIStandardAjaxEventModel.h"

#import "MJExtension.h"

@implementation HTMIStandardActionModel

- (id)copyWithZone:(NSZone *)zone {
    HTMIStandardActionModel *model = [[[self class] allocWithZone:zone] init];
    
    model.actionId = [self.actionId copy];
    model.actionName = [self.actionName copy];
    model.actionEvent = [self.actionEvent copy];
    
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
