//
//  HTMIStandardSignModel.h
//  MXClient
//
//  Created by wlq on 2018/02/07.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMIStandardSignModel : NSObject<NSCopying>

/**
 签名的类型：
 1,是签名图片（有唯一标示）；2，是人员姓名
 例如慧正v6的签名字段是这么设计的：有了两种：
 OauserID#签名唯一标示#1；
 OauserID#签名唯一标示#2
 */
@property (nonatomic, assign) NSInteger signType;

/**
 用户姓名
 */
@property (nonatomic, copy) NSString *userName;

/**
 签批时间
 */
@property (nonatomic, copy) NSString *saveTime;

/**
 用户编号
 */
@property (nonatomic, copy) NSString *userId;

/**
 登录名
 */
@property (nonatomic, copy) NSString *loginName;

/**
 签名图片base64。
 （SignType为1时使用，但是如果SignType=1，但SignPic为空SignPicUrl也为空，即显示不了图片，移动端需要显示姓名。显示最终不能为空。）
 */
@property (nonatomic, copy) NSString *signPic;

/**
 签名图片Url
 优化，移动端二级缓存时使用
 */
@property (nonatomic, copy) NSString *signPicUrl;


@end
