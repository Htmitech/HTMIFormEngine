//
//  HTMIStandardOpintionModel.h
//  MXClient
//
//  Created by wlq on 2018/1/24.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMIStandardOpintionModel : NSObject<NSCopying>

/**
 意见内容
 */
@property (nonatomic, copy) NSString *opinionText;

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
 签名图片base64
 */
@property (nonatomic, copy) NSString *signPic;

/**
 签名图片Url
 */
@property (nonatomic, copy) NSString *signPicUrl;


@end
