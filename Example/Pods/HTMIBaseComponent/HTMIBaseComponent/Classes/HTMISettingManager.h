//
//  HTMISettingManager.h
//  MXClient
//
//  Created by wlq on 16/6/14.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "HTMIConst.h"
//image分类
//#import "UIImage+WM.h"
//新增字体方法
#import "UIFont+HTMIFont.h"

#ifndef HTMIApplicationHueType_h
#define HTMIApplicationHueType_h
typedef NS_ENUM(NSInteger, HTMIApplicationHueType) {
    HTMIApplicationHueWhite = 0,           //默认
    HTMIApplicationHueRed = 1,            //第一个字符.
    HTMIApplicationHueBlue = 2
    
};

#endif /* HTMIHeaderImageType_h */

////应用文件夹字符串
//#define APPDIRECTORY(app_id) [NSString stringWithFormat:@"%@/%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject],kHTMI_AppPath,app_id]


/**
 * 应用程序级别的设置 Start
 */

//默认的也是可以配置的，1：磁贴，2：规则网格，3：待办列表，4：功能导航
#define kDefaultFirstPageType 2

/**应用程序色调   //用来控制按钮字体颜色以及EMI的样式控制*/
#define kApplicationHue  kSetting.applicationHue//@"_blue" //_red,_blue,_white

/** 导航栏按钮颜色 */
#define kHTMI_NavigationBarButtonColor  kSetting.navigationBarButtonColor

/** 控件颜色（根据色调确定）*/
#define kHTMI_HUEControlColor  kSetting.controlColor

/** 默认的蓝色色调的色值 */
#define kApplicationHueBlueColor [UIColor colorWithRed:70/255.0 green:76/255.0 blue:98/255.0 alpha:1.0]

/** 页面设置单例类 */
#define kSetting  [HTMISettingManager manager]

/** 导航栏颜色（色调） */
#define navBarColor kSetting.navigationBarColor

/** 导航栏字体颜色（用来设置自定义View导航栏）*/
#define HTMINavigationBarTitleFontColor kSetting.navigationBarTitleFontColor//一种是白色RGB(249, 249, 249)一种是黑色RGB(67, 67, 67)
/** 导航栏字体大小（用来设置自定义View导航栏）*/
#define HTMINavigationBarTitleFontSize [UIFont myFontWithName:@"HelveticaNeue-CondensedBlack" size:18.0]

/** 导航栏字体大小（用来设置自定义View导航栏）*/
#define HTMINavigationBarButtonItemTitleFontSize [UIFont myFontWithName:@"HelveticaNeue-CondensedBlack" size:14.0]

/** 导航栏字体 （用来设置系统导航栏） */
#define HTMINavigationBarTitleFont \
[NSDictionary dictionaryWithObjectsAndKeys:\
HTMINavigationBarTitleFontColor,NSForegroundColorAttributeName,\
HTMINavigationBarTitleFontSize,\
NSFontAttributeName,nil]

/** 导航栏字体 （用来设置系统导航栏） */
#define HTMINavigationBarButtonItemTitleFont \
[NSDictionary dictionaryWithObjectsAndKeys:\
HTMINavigationBarTitleFontColor,NSForegroundColorAttributeName,\
HTMINavigationBarButtonItemTitleFontSize,\
NSFontAttributeName,nil]

/** SegmentedControl背景色 */
#define kSegmentedControlBackgroundColor kSetting.segmentedControlBackgroundColor

/** SegmentedControl色调 */
#define kSegmentedControlTintColor kSetting.segmentedControlTintColor

/** 选择页面也签的高度 */
#define kChoosePageTagHight kSetting.choosePageTagHight

/**  分割线颜色 */
#define kSeparaterColor RGB(239, 240, 240)

//arc4random_uniform(200)
//头像随机色
#define kRandomColor kSetting.randomColor
//RGB((150+(arc4random() % 100)), (150+(arc4random() % 100)), (150+(arc4random() % 100)))

/** 应用列数 */
#define kAppColumnNumber kSetting.appColumnNumber


/**
 * 应用程序级别的设置 End
 */

@interface HTMISettingManager : NSObject

+ (instancetype)manager;

/**
 *  导航栏颜色
 */
@property (nonatomic, copy) UIColor *navigationBarColor;

/**
 *  导航栏按钮颜色
 */
@property (nonatomic, copy) UIColor *navigationBarButtonColor;

/**
 *  普通控件颜色（根据导航栏色调配置）
 */
@property (nonatomic, copy) UIColor *controlColor;

/**
 *  导航栏字体颜色
 */
@property (nonatomic, copy) UIColor *navigationBarTitleFontColor;

/**
 *  选项卡控件背景色
 */
@property (nonatomic, copy) UIColor *segmentedControlBackgroundColor;

/**
 *  选项卡控件色调
 */
@property (nonatomic, copy) UIColor *segmentedControlTintColor;

/**
 *  选择页面也签的高度
 */
@property (nonatomic, assign)NSInteger choosePageTagHight;

/**
 *  随机色
 */
@property (nonatomic, copy) UIColor *randomColor;

/**
 *  应用色调
 */
@property (nonatomic, assign ,readonly) HTMIApplicationHueType applicationHue;

/**
 应用中心列数
 */
@property (nonatomic, assign) NSInteger appColumnNumber;

/**
 门户默认字体大小Style-1 ~ 3
 */
@property (nonatomic, assign) NSInteger portalDefaultFontStyle;

/**
 用户设置的门户字体大小-1 ~ 3
 */
@property (nonatomic, assign) NSInteger customPortalFontStyle;

/**
 我们可以使用的字体大小1~5
 */
@property (nonatomic, assign) NSInteger fontSizeCoefficient;


@property (nonatomic, assign)BOOL fromLoginView;

/**
 设置色调类型

 @param applicationHue 色调类型
 */
- (void)setUpApplicationHue:(HTMIApplicationHueType)applicationHue;

#pragma mark - 整个应用的设置方法

/**
 设置Tabbar的样式
 */
- (void)setUpTabbarStyle:(UITabBarController *)tabBarController;

/**
 设置整个应用的色调相关的
 */
//- (void)setUpAppHue;


@end
