//
//  HTMIItemOpintionModel.m
//  MXClient
//
//  Created by 赵志国 on 2017/10/16.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIItemOpintionModel.h"
#import "HTMIStandardOpintionModel.h"

#import "MJExtension.h"

@implementation HTMIItemOpintionModel

/**
 使用标准意见模型初始化

 @param standardOpintionModel 标准意见模型
 @return 意见模型
 */
- (instancetype)initWithStandardOpintionModel:(HTMIStandardOpintionModel *)standardOpintionModel
{
    self = [super init];
    if (self) {
        _opinionString = standardOpintionModel.opinionText;
        _userNameString = standardOpintionModel.userName;
        _saveTimeString = standardOpintionModel.saveTime;
        _userIDString = standardOpintionModel.userId;
        _loginName = standardOpintionModel.loginName;
        _signPic = standardOpintionModel.signPic;
        _signPicUrl = standardOpintionModel.signPicUrl;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    HTMIItemOpintionModel *model = [[[self class] allocWithZone:zone] init];
    
    model.opinionString = [self.opinionString copy];
    model.userNameString = [self.userNameString copy];
    model.saveTimeString = [self.saveTimeString copy];
    model.userIDString = [self.userIDString copy];
    
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}


@end
