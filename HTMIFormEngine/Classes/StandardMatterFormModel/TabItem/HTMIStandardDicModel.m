//
//  HTMIStandardDicModel.m
//  MXClient
//
//  Created by wlq on 2018/1/24.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIStandardDicModel.h"

#import "MJExtension.h"

@implementation HTMIStandardDicModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"dicId" : @"id",
             };
}

- (id)copyWithZone:(NSZone *)zone {
    
    HTMIStandardDicModel *model = [[[self class] allocWithZone:zone] init];
    
    model.dicId = [self.dicId copy];
    model.name = [self.name copy];
    model.value = [self.value copy];
    
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
