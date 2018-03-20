//
//  HTMIStandardDicModel.h
//  MXClient
//
//  Created by wlq on 2018/1/24.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMIStandardDicModel : NSObject<NSCopying>

/**
 字典Id
 */
@property (nonatomic, copy) NSString *dicId;

/**
 字典名称
 */
@property (nonatomic, copy) NSString *name;

/**
 字典Value
 */
@property (nonatomic, copy) NSString *value;

@end
