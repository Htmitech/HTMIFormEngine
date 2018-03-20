//
//  HTMIItemOpintionModel.h
//  MXClient
//
//  Created by 赵志国 on 2017/10/16.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTMIStandardOpintionModel;

@interface HTMIItemOpintionModel : NSObject<NSCopying>

/**
 意见内容
 */
@property (nonatomic, copy) NSString *opinionString;

/**
 用户姓名
 */
@property (nonatomic, copy) NSString *userNameString;

/**
 签批时间
 */
@property (nonatomic, copy) NSString *saveTimeString;

/**
 用户编号
 */
@property (nonatomic, copy) NSString *userIDString;

//wlq add 20180124 新增的三个字段
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


+ (HTMIItemOpintionModel *)getItemOpinionModelWithDict:(NSDictionary *)dict;

/**
 使用标准意见模型初始化
 
 @param standardOpintionModel 标准意见模型
 @return 意见模型
 */
- (instancetype)initWithStandardOpintionModel:(HTMIStandardOpintionModel *)standardOpintionModel;


@end
