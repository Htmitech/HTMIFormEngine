//
//  HTMIStandardAttachModel.m
//  MXClient
//
//  Created by wlq on 2018/01/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIStandardAttachModel.h"

#import "MJExtension.h"

@implementation HTMIStandardAttachModel

- (id)copyWithZone:(NSZone *)zone {
    
    HTMIStandardAttachModel *model = [[[self class] allocWithZone:zone] init];
    
    model.attachmentId = [self.attachmentId copy];
    model.attachmentTitle = [self.attachmentTitle copy];
    model.attachmentSize = [self.attachmentSize copy];
    model.attachmentType = [self.attachmentType copy];
    model.attachmentDateTime = [self.attachmentDateTime copy];
    model.encrypt = self.encrypt;
    
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
