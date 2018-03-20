//
//  HTMISettingManager.m
//  MXClient
//
//  Created by wlq on 16/6/14.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import "HTMISettingManager.h"

#import "UIColor+Hex.h"
//
//#import "HTMIAppExecutionEngine.h"
//
//#import "HTMIPortalModel.h"
//
//#import "HTMIAddressBookManager.h"
//
//#import "HTMIWorkFlowComponetManager.h"
//
//#import "HTMIFilesCenterComponetManager.h"
//#import "HTMIAppModel.h"
//
//#import "SDImageCache.h"
//
//#import "HTMIUserdefaultHelper.h"
//
//#import "HTMITabBarItem.h"
//#import "HTMIBadgeImport.h"
//
//#import "MXNetworkListView.h"
//
//#import "HTMIUserdefineModel.h"
//#import "HTMIDBManager.h"
//
//#import "HTMISetUpMXTool.h"
//
//#import "HTMIDBManager+HTMIAppCenter.h"

@implementation HTMISettingManager

@synthesize applicationHue = _applicationHue;
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
        _customPortalFontStyle = -10;
    }
    return self;
}

- (NSInteger)fontSizeCoefficient{
    //门户默认
    NSInteger fontStyle = 0;
    //门户设置的默认的
    //判断本地表是否有记录
    
    fontStyle = _customPortalFontStyle;
    
    if (fontStyle <= -10){//判断是否自定义了字体大小
        
        fontStyle = _portalDefaultFontStyle;
    }
    
    
    NSInteger value =  fontStyle + 2;
    if (value < 1) {
        value = 1;
    }
    else if(value > 5){
        value = 5;
    }
    
    return value;
    
}

- (void)setUpApplicationHue:(HTMIApplicationHueType)applicationHue{
    
    _applicationHue = applicationHue;
}

#pragma mark - Getters and Setters

- (HTMIApplicationHueType)applicationHue{
    
    return _applicationHue;
}

- (UIColor *)navigationBarColor{
    
    int hue = kApplicationHue;
    if (hue == HTMIApplicationHueWhite) {
        return [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    }
    else if (hue == HTMIApplicationHueRed) {
        return [UIColor colorWithRed:223/255.0 green:48/255.0 blue:49/255.0 alpha:1.0];
    }
    else if (hue == HTMIApplicationHueBlue) {
        return [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    }
    else{
        return [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];//默认白色导航栏
    }
}

- (UIColor *)navigationBarButtonColor{
    
    if (kApplicationHue == HTMIApplicationHueWhite) {
        
        return kApplicationHueBlueColor;
    }
    else{
        
        return [UIColor whiteColor];
    }
}

- (UIColor *)controlColor{
    
    if (kApplicationHue == HTMIApplicationHueWhite) {//如果是白色色调
        
        return kApplicationHueBlueColor;
    }
    else{
        return navBarColor;
    }
}


- (UIColor *)navigationBarTitleFontColor{
    
    
    if (kApplicationHue == HTMIApplicationHueWhite) {//如果是白色色调，导航栏字体颜色需要改成黑色
        _navigationBarTitleFontColor = [UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1.0];
    }
    else{
        _navigationBarTitleFontColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    }
    return _navigationBarTitleFontColor;
}


- (UIColor *)segmentedControlBackgroundColor{
    
    
    if (kApplicationHue == HTMIApplicationHueWhite) {//如果是白色色调
        _segmentedControlBackgroundColor = [UIColor whiteColor];
    }
    else{
        _segmentedControlBackgroundColor = navBarColor;
    }
    
    return   _segmentedControlBackgroundColor;
}

- (UIColor *)segmentedControlTintColor{
    
    if (kApplicationHue == HTMIApplicationHueWhite) {//如果是白色色调
        _segmentedControlTintColor = kApplicationHueBlueColor;
    }
    else{
        _segmentedControlTintColor = [UIColor whiteColor];
    }
    
    return   _segmentedControlTintColor;
}

- (UIColor *)randomColor{
    
    ///取名字的32位md5最后一位  对应的  ASCII 十进制值 的末尾值 ( 0 - 9 ) 对应的颜色为底色
    NSInteger index = arc4random() % 10;//(NSInteger)[[string md5_32] characterAtIndex:31];
    //约定的颜色值
    NSString *colorHex = @"0DB8F6,00D3A3,FCD240,F26C13,EE523D,4C90FB,FFBF45,48A6DF,00B25E,EC606C";
    NSArray *colorHexArray = [colorHex componentsSeparatedByString:@","];
    //取到颜色值
    _randomColor = [UIColor colorFromHexCode:[colorHexArray objectAtIndex:index]];
    
    return _randomColor;
}

//- (NSInteger)fontStyle{
//    NSInteger value =  _fontStyle + 2;
//    if (value < 1) {
//        value = 1;
//    }
//    else if(value > 6){
//        value = 6;
//    }
//    return value;
//}

/**
 设置Tabbar的样式
 */
- (void)setUpTabbarStyle:(UITabBarController *)tabBarController{
    //设置底部导航栏样式，字体大小不随应用字体大小改变
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : kHTMI_HUEControlColor,NSFontAttributeName : [UIFont mySystemFontOfSize:13.0] }
                                             forState:UIControlStateHighlighted];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont mySystemFontOfSize:13.0] }
                                             forState:UIControlStateNormal];
    
    [[UITabBar appearance]setTintColor:kHTMI_HUEControlColor];
    
    [tabBarController.tabBar setTintColor:kHTMI_HUEControlColor];//直接进行修改
}


@end
