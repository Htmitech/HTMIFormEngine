//
//  Userdefault.h
//  Express
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMIUserdefaultHelper : NSObject

+(void)clearCache;

/**
 是否设置过字体
 
 @return 是否设置过字体
 */
+ (BOOL)hasSetNewFontSizeCoefficient;

/**
 保存是否已经设置字体大小
 
 @param a 是否已经设置字体大小
 */
+ (void)defaultSaveHasSetFontSize:(BOOL)a;

/**
 推送字典数组
 
 @return 推送字典数组
 */
+(NSMutableArray*)defaultLoadNotificationArray;

/**
 推送字典数组存数据
 
 @param a 推送信息
 */
+(void)defaultAddToNotificationArray:(NSDictionary *)a;

/**
 移除第一条推送
 */
+(void)defaultRemoveFirstNotificationArray;

//设置字体大小系数，1到6  2为默认标准
+(void)defaultSaveNewFontSizeCoefficient:(NSInteger )coefficient;

//
+(void)defaultSaveFontEditePageCoefficient:(NSInteger )coefficient;
//
+(NSInteger)defaultLoadFontEditePageCoefficient;


/**
 保存Context字典对象
 
 @param context Context字典对象
 */
+(void)defaultSaveContext:(NSDictionary *)context;

/**
 获取Context字典对象
 
 @return Context字典对象
 */
+(NSDictionary *)defaultLoadContext;

/**
 保存portalMessage字典对象
 
 */
+(void)defaultSavePortalMessage:(NSDictionary *)portalMessage;

/**
 读取 portalMessage

 */
+(NSDictionary *)defaultLoadPortalMessage;


+(NSInteger)defaultLoadNewFontSizeCoefficient;

//读取比例系数 (0.925~1.30)
+(float )defaultLoadNewCoefficient;


////用户ID
+(NSString*)defaultLoadUserID;
+(void)defaultSaveUserID:(NSString *)a;

//是不是EMIUser
+ (NSString*)defaultLoadIsEMIUser;
+ (void)defaultSaveIsEMIUser:(NSString *)a;


//用户OAID
+ (NSString*)defaultLoadOAUserID;
+ (void)defaultSaveOAUserID:(NSString *)a;

//通讯里同步时间戳
+ (NSString *)defaultLoadAddressBookSynchronizationeventStamp;
+ (void)defaultSaveAddressBookSynchronizationeventStamp:(NSString *)a;

//通讯录文件地址
+ (NSString *)defaultLoadAddressBookPath;
+ (void)defaultSaveAddressBookPath:(NSString *)a;

//界面风格
+ (NSString *)defaultLoadViewStyle;
+ (void)defaultSaveViewStyle:(NSString *)a;

//报异常
+(NSString*)defaultLoadbug;
+(void)defaultSavebug:(NSString *)a;

//工作流id
+(NSString *)defaultLoadCurrentAppId;
+(void)defaultSaveCurrentAppId:(NSString *)a;

//appVersionid
+(NSString *)defaultLoadCurrentAppVersionId;
+(void)defaultSaveCurrentAppVersionId:(NSString *)a;

//refreshToken
+(NSString *)defaultLoadRefreshToken;
+(void)defaultSaveRefreshToken:(NSString *)a;

//accessToken
+(NSString*)defaultLoadAccessToken;
+(void)defaultSaveAccessToken:(NSString *)a;

//PortalID
+(NSString*)defaultLoadPortalID;
+(void)defaultSavePortalID:(NSString *)a;

//经度
+ (NSString*)defaultLoadLongitude;
+ (void)defaultSaveLongitude:(NSString *)a;

//纬度
+ (NSString*)defaultLoadLatitude;
+ (void)defaultSaveLatitude:(NSString *)a;

//第一次从数据库中获取应用中心数据
+ (BOOL)defaultLoadFirstloadAppCenterDataFromDB;
+ (void)defaultSaveFirstloadAppCenterDataFromDB:(BOOL)a;

//应用中心第一次使用
+ (BOOL)defaultLoadAppCenterFirstStart;
+ (void)defaultSaveAppCenterFirstStart:(BOOL)a;

//工作圈第一次使用
+ (BOOL)defaultLoadCircleFirstStart;
+ (void)defaultSaveCircleFirstStart:(BOOL)a;

//工作流构件第一次使用
+ (BOOL)defaultLoadWorkFlowComponentFirstStart;
+ (void)defaultSaveWorkFlowComponentFirstStart:(BOOL)a;

//流程第一次使用
+ (BOOL)defaultLoadMatterFlowFirstStart;
+ (void)defaultSaveMatterFlowFirstStart:(BOOL)a;

//应用程序第一次使用
+ (BOOL)defaultLoadSystemFirstStart;
+ (void)defaultSaveSystemFirstStart:(BOOL)a;

//密码
+ (NSString *)defaultLoadPassWord;
+ (void)defaultSavePassWord:(NSString *)a;

//临时账号 登录名小写
+ (NSString *)defaultLoadTempLoginName;
//临时账号 登录名小写
+ (void)defaultSaveTempLoginName:(NSString *)a;

//账号
+ (void)defaultSaveLoginName:(NSString *)a;
+ (NSString *)defaultLoadLoginName;

/**
 正文
 */
+(NSString *)defaultLoadBodyFile;

+(void)defaultSaveBodyFile:(NSString *)a;

@end
