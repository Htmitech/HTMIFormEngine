//
//  HTMITabEventModel.m
//  MXClient
//
//  Created by wlq on 2018/1/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIStandardTabEventModel.h"

#import "MJExtension.h"

@implementation HTMIStandardTabEventModel

- (id)copyWithZone:(NSZone *)zone {
    
    HTMIStandardTabEventModel *model = [[self class] allocWithZone:zone];
    
    model.eventType = [self.eventType copy];
    model.eventApi = [self.eventApi copy];
    
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
