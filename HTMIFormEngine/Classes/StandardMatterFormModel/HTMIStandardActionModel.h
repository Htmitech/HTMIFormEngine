//
//  HTMIStandardActionModel.h
//  MXClient
//
//  Created by wlq on 2018/01/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HTMIStandardAjaxEventModel;

@interface HTMIStandardActionModel : NSObject<NSCopying>

/**
 操作按钮Id
 */
@property (nonatomic, copy) NSString *actionId;

/**
 操作按钮名称
 */
@property (nonatomic, copy) NSString *actionName;

/**
 事件类型（ajaxEvent）
 */
@property (nonatomic, copy) HTMIStandardAjaxEventModel *actionEvent;

@end
