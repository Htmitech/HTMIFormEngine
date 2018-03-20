//
//  ACMediaModel.m
//
//  Created by caoyq on 16/12/25.
//  Copyright © 2016年 ArthurCao. All rights reserved.
//

#import "ACMediaModel_form.h"

@implementation ACMediaModel_form

- (BOOL)isEqual:(id)object{
    
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToACMediaModel:(ACMediaModel_form *)object];
    
}

- (BOOL)isEqualToACMediaModel:(ACMediaModel_form *)mediaModel {
    if (!mediaModel) {
        return NO;
    }
    
    BOOL haveEqualNames = [self.name isEqualToString:mediaModel.name];
    
    return haveEqualNames;
}

@end
