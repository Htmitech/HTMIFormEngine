//
//  HTMIApplicationHub.h
//  HTMIFormComponent
//
//  Created by 赵志国 on 2018/3/16.
//  Copyright © 2018年 htmitech.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "HTMISettingManager.h"

@interface HTMIApplicationHubManager : NSObject

+ (instancetype)manager;

@property (nonatomic, strong, readonly) UIColor *blueForWhiteControlColor;

@property (nonatomic, assign, readonly) int applicationHubType;

/**
 是否可聊天
 */
@property (nonatomic, assign, readonly) BOOL isCanChart;

/**
 设置色调类型
 
 @param applicationHue 色调类型
 */
- (void)setUpApplicationHue:(int)applicationHue;//HTMIApplicationHueType

/**
 设置表单点击用户名聊天权限
 
 @param isCanChart 是否可聊天
 */
- (void)setIsCanChart:(BOOL)isCanChart;

@end
