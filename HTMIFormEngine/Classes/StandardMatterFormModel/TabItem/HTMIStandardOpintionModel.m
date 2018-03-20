//
//  HTMIStandardOpintionModel.m
//  MXClient
//
//  Created by wlq on 2018/1/24.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIStandardOpintionModel.h"
#import "MJExtension.h"

@implementation HTMIStandardOpintionModel

- (id)copyWithZone:(NSZone *)zone {
    HTMIStandardOpintionModel *model = [[[self class] allocWithZone:zone] init];
    
    model.opinionText = [self.opinionText copy];
    model.userName = [self.userName copy];
    model.saveTime = [self.saveTime copy];
    model.userId = [self.userId copy];
    model.loginName = [self.loginName copy];
    model.signPic = [self.signPic copy];
    model.signPicUrl = [self.signPicUrl copy];
    
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
