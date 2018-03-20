//
//  HTMIFormComponentHeader.h
//  MXClient
//
//  Created by wlq on 2017/8/22.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "UtilsMacros.h"

#ifndef HTMIFormComponentHeader_h
#define HTMIFormComponentHeader_h

/**
 *  意见、签名人名颜色
 */
#define eidtColor [UIColor colorWithRed:41/255.0 green:123/255.0 blue:251/255.0 alpha:1.0]//蓝

/**
 *  必填时添加的背景色 水印
 */
#define mustInputColor [UIColor colorWithRed:254/255.0 green:250/255.0 blue:235/255.0 alpha:0.5]//黄

/**
 *  可编辑时的边框颜色
 */
#define borderCorlor [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]//灰

/**
 *  所有行的最低高度
 */
#define cellMinHeight kH6(50)

/**
 *  可编辑时边框距左边的距离
 */
#define borderLeftWidth kW6(5)

/**
 *  可编辑时边框距上边的距离
 */
#define borderTopHeight kH6(5)

/**
 *  字体距左边的距离
 */
#define stringLeftWidth kW6(12)

/**
 *  字体距上边的距离
 */
#define stringTopHeight kH6(12)

/**
 必填项未填警告红色提示框
 */
#define WARNING_BORDER_COLOR [UIColor colorWithRed:233/255.0 green:48/255.0 blue:49/255.0 alpha:1.0].CGColor


/**
 无警告时
 */
#define NORMAL_BORDER_COLOR [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor



static CGFloat extFieldAudioSingleHeight = 50+24;

#endif /* HTMIFormComponentHeader_h */


