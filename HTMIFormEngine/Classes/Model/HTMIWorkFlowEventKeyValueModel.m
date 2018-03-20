//
//  HTMIWorkFlowEventKeyValueModel.m
//  MXClient
//
//  Created by wlq on 2018/1/31.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIWorkFlowEventKeyValueModel.h"

@implementation HTMIWorkFlowEventKeyValueModel

- (instancetype)initWithFieldKey:(NSString *)fieldKey fieldValue:(NSString *)fieldValue
{
    self = [super init];
    if (self) {
        _fieldKey = fieldKey;
        _fieldValue = fieldValue;
    }
    return self;
}
@end
