//
//  HTMIWorkFlowEventKeyValueModel.h
//  MXClient
//
//  Created by wlq on 2018/1/31.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMIWorkFlowEventKeyValueModel : NSObject

/**
 字段Key
 */
@property (nonatomic, copy) NSString *fieldKey;

/**
 字段值
 */
@property (nonatomic, copy) NSString *fieldValue;

- (instancetype)initWithFieldKey:(NSString *)fieldKey fieldValue:(NSString *)fieldValue;

@end
