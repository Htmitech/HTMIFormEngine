//
//  HTMIStandardSignModel.m
//  MXClient
//
//  Created by wlq on 2018/02/07.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIStandardSignModel.h"

#import "MJExtension.h"

@implementation HTMIStandardSignModel

- (id)copyWithZone:(NSZone *)zone {
    HTMIStandardSignModel *model = [[[self class] allocWithZone:zone] init];
    
    model.signType = self.signType;
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
