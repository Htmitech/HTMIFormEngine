//
//  HTMIStandardTrackInfoModel.h
//  MXClient
//
//  Created by wlq on 2018/1/23.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMIStandardTrackInfoModel : NSObject<NSCopying>

/**
 节点名称
 */
@property (nonatomic, strong) NSString *trackName;

/**
 节点id
 */
@property (nonatomic, strong) NSString *trackId;

@end
