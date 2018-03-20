//
//  HTMIStandardAjaxEventModel.h
//  MXClient
//
//  Created by wlq on 2018/1/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMIStandardAjaxEventModel : NSObject<NSCopying>

/**
 事件触发类型：
  -1，没有定义事件；
  0，load完成当前Tab或form页面时，触发
  1，字段内容值变化（包括，下拉选项选值变化；文本输入的值变化；单选框、多选框的值变化；等等）时触发；
  2，点击事件发生（如，选择点击之后发生，按钮的点击等）是触发；
 */
@property (nonatomic, copy) NSString *eventType;

/**
 事件接口
 */
@property (nonatomic, copy) NSString *eventApi;

@end
