//
//  HTMIFormChangedFieldModel.h
//  MXClient
//
//  Created by wlq on 2017/8/28.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HTMIItemDicsModel;

@interface HTMIFormChangedFieldModel : NSObject

/**
 字段key
 */
@property (nonatomic,copy) NSString *fieldKey;

/**
 字段值
 */
@property (nonatomic,copy) NSString *fieldValue;

/**
 字段字典
 */
@property (nonatomic,strong) NSArray <HTMIItemDicsModel *> *dics;

/**
 下拉选项的默认选择index
 */
@property (nonatomic,copy) NSString *defaultDicIndex;

/**
 9，不受影响；0,显示；1,隐藏；
 */
@property (nonatomic, assign) NSInteger hiden;

/**
 9，不受影响；0,只读不可编辑；1,可编辑；
 */
@property (nonatomic, assign) NSInteger editable;


@end

