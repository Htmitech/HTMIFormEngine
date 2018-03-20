//
//  HTMIStandardTrackInfoModel.m
//  MXClient
//
//  Created by 赵志国 on 2018/1/14.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIStandardTrackInfoModel.h"

#import "MJExtension.h"

@implementation HTMIStandardTrackInfoModel

- (id)copyWithZone:(NSZone *)zone {
    
    HTMIStandardTrackInfoModel *model = [[self class] allocWithZone:zone];
    
    model.trackId = [self.trackId copy];
    model.trackName = [self.trackName copy];
    
    return model;
}

- (NSString *)description {
    return [self mj_keyValues].description;
}

@end
