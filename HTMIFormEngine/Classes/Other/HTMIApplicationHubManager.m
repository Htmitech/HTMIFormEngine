//
//  HTMIApplicationHub.m
//  HTMIFormComponent
//
//  Created by 赵志国 on 2018/3/16.
//  Copyright © 2018年 htmitech.com. All rights reserved.
//

#import "HTMIApplicationHubManager.h"

#import "HTMISettingManager.h"

@interface HTMIApplicationHubManager ()

@property (nonatomic, strong, readwrite) UIColor *blueForWhiteControlColor;

@property (nonatomic, assign, readwrite) int applicationHubType;

/**
 是否可聊天
 */
@property (nonatomic, assign, readwrite) BOOL isCanChart;

@end

@implementation HTMIApplicationHubManager

static id _manager = nil;
// 返回单例
+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super alloc] init];
    });
    
    return _manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setUpApplicationHue:(int)applicationHue {
    
    _applicationHubType = applicationHue;
    
    if (applicationHue == HTMIApplicationHueWhite) {
        
        self.blueForWhiteControlColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    }
    else if (applicationHue == HTMIApplicationHueRed) {
        
        self.blueForWhiteControlColor = [UIColor colorWithRed:223/255.0 green:48/255.0 blue:49/255.0 alpha:1.0];
    }
    else if (applicationHue == HTMIApplicationHueBlue) {
        
        self.blueForWhiteControlColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    }
    else{
        
        self.blueForWhiteControlColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];//默认白色导航栏
    }
}

/**
 设置表单点击用户名聊天权限
 
 @param isCanChart 是否可聊天
 */
- (void)setIsCanChart:(BOOL)isCanChart {
    
    _isCanChart = isCanChart;
}

@end
