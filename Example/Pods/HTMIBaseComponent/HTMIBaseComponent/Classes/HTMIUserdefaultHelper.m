//
//  Userdefault.m
//  Express
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HTMIUserdefaultHelper.h"

#import "HTMISettingManager.h"

//#import "HTMIUserdefineModel.h"

//#import "HTMIDBManager.h"

#define USERDEFAULT [NSUserDefaults standardUserDefaults]
#define HTMI_FONT_COEFFICIENT_New @"HTMIFontSizeCoefficient"
#define HTMI_FONT_COEFFICIENT_Old @"HTMIOldFontSizeCoefficient"

@implementation HTMIUserdefaultHelper

+(NSMutableArray*)defaultLoadNotificationArray
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"notificationArray"] ==  nil ? @[]:[defaults objectForKey:@"notificationArray"];
}

+(void)defaultAddToNotificationArray:(NSDictionary *)a
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[self defaultLoadNotificationArray]];
    [arr addObject:a];
    [defaults setObject:arr  forKey:@"notificationArray"];
    [defaults synchronize];
}

+(void)defaultRemoveFirstNotificationArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[self defaultLoadNotificationArray]];
    if (arr.count > 0) {
        [arr removeObjectAtIndex:0];
    }
    [defaults setObject:arr  forKey:@"notificationArray"];
    [defaults synchronize];
}


+ (BOOL)hasSetNewFontSizeCoefficient{
    
    NSString * hasSet = [USERDEFAULT objectForKey:@"HasSetFontSize"];
    
    if (hasSet && hasSet.length > 0) {
        return YES;
    }
    return NO;
}

/**
 保存是否已经设置字体大小
 
 @param a 是否已经设置字体大小
 */
+ (void)defaultSaveHasSetFontSize:(BOOL)a{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if (a) {
        [defaults setObject:@"HasSetFontSize"  forKey:@"HasSetFontSize"];
    }
    else{
        [defaults removeObjectForKey:@"HasSetFontSize"];
    }
    
    [defaults synchronize];
}

+(void)defaultSaveNewFontSizeCoefficient:(NSInteger )coefficient{
    
    [USERDEFAULT setObject:@"HasSetFontSize" forKey:@"HasSetFontSize"];
    
    [USERDEFAULT setInteger:coefficient forKey:HTMI_FONT_COEFFICIENT_New];
    [USERDEFAULT synchronize];
}

+(void)defaultSaveContext:(NSDictionary *)context{
    [USERDEFAULT setObject:context forKey:@"kContextDictionary"];
    [USERDEFAULT synchronize];
}
+(void)defaultSavePortalMessage:(NSDictionary *)portalMessage{
    [USERDEFAULT setObject:portalMessage forKey:@"kPortalMessage"];
    [USERDEFAULT synchronize];
}

+(NSDictionary *)defaultLoadContext{
    
    return [USERDEFAULT objectForKey:@"kContextDictionary"] ==  nil ? @{}:[USERDEFAULT objectForKey:@"kContextDictionary"];
}
+(NSDictionary *)defaultLoadPortalMessage{
    
    return [USERDEFAULT objectForKey:@"kPortalMessage"] ==  nil ? @{}:[USERDEFAULT objectForKey:@"kPortalMessage"];
}

+(NSInteger)defaultLoadNewFontSizeCoefficient{
    
    return [HTMISettingManager manager].fontSizeCoefficient;
}

+(float )defaultLoadNewCoefficient{
    
    NSInteger coefficient =[HTMIUserdefaultHelper defaultLoadNewFontSizeCoefficient];
    //    return 0.075*(coefficient-2)+1;
    return 0.1*(coefficient-2)+1;
}


//用户OAID
+ (NSString*)defaultLoadOAUserID{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"OA_UserId"] ==  nil ? @"":[defaults objectForKey:@"OA_UserId"];
}

+ (void)defaultSaveOAUserID:(NSString *)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"OA_UserId"];
    [defaults synchronize];
}

//用户ID
+ (NSString*)defaultLoadUserID{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"UserID"] ==  nil ? @"":[defaults objectForKey:@"UserID"];
}

+ (void)defaultSaveUserID:(NSString *)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"UserID"];
    [defaults synchronize];
}

//是不是EMIUser
+ (NSString*)defaultLoadIsEMIUser{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"htmi_IsEMIUser"] ==  nil ? @"":[defaults objectForKey:@"htmi_IsEMIUser"];
}

+ (void)defaultSaveIsEMIUser:(NSString *)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%@",a]  forKey:@"htmi_IsEMIUser"];
    [defaults synchronize];
}

//通讯录同步时间戳
+ (NSString *)defaultLoadAddressBookSynchronizationeventStamp{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"AddressBookSynchronizationeventStamp"]  ==  nil ? @"": [defaults objectForKey:@"AddressBookSynchronizationeventStamp"];
}
+ (void)defaultSaveAddressBookSynchronizationeventStamp:(NSString *)a{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"AddressBookSynchronizationeventStamp"];
    [defaults synchronize];
}

//通讯录文件地址
+ (NSString *)defaultLoadAddressBookPath{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"htmi_db"] ==  nil ? @"": [defaults objectForKey:@"htmi_db"];
}
+ (void)defaultSaveAddressBookPath:(NSString *)a{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"htmi_db"];
    [defaults synchronize];
}

//界面风格
+ (NSString *)defaultLoadViewStyle{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:@"fengge"] ==  nil ? @"": [defaults objectForKey:@"fengge"];
}
+ (void)defaultSaveViewStyle:(NSString *)a{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"fengge"];
    [defaults synchronize];
}



+ (NSString*)defaultLoadbug
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:@"bug"] ==  nil ? @"": [defaults objectForKey:@"bug"];
}

+ (void)defaultSavebug:(NSString *)a
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"bug"];
    [defaults synchronize];
}

//appid
+(NSString *)defaultLoadCurrentAppId{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"htmi_AppId"] ==  nil ? @"": [defaults objectForKey:@"htmi_AppId"];
}

+(void)defaultSaveCurrentAppId:(NSString *)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"htmi_AppId"];
    [defaults synchronize];
}

//appVersionid
+(NSString *)defaultLoadCurrentAppVersionId{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"htmi_AppCurrentVersionId"] ==  nil ? @"": [defaults objectForKey:@"htmi_AppCurrentVersionId"];
}

+(void)defaultSaveCurrentAppVersionId:(NSString *)a{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"htmi_AppCurrentVersionId"];
    [defaults synchronize];
}

//refreshToken
+(NSString *)defaultLoadRefreshToken;
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:@"htmiRefreshToken"] ==  nil ? @"": [defaults objectForKey:@"htmiRefreshToken"];
}

+(void)defaultSaveRefreshToken:(NSString *)a;
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"htmiRefreshToken"];
    [defaults synchronize];
}

//accessToken
+(NSString*)defaultLoadAccessToken;
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:@"htmiAccessToken"] ==  nil ? @"": [defaults objectForKey:@"htmiAccessToken"];
}

+(void)defaultSaveAccessToken:(NSString *)a;
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"htmiAccessToken"];
    [defaults synchronize];
}
//PortalID
+(NSString*)defaultLoadPortalID
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:@"HTMIPortalID"] ==  nil ? @"": [defaults objectForKey:@"HTMIPortalID"];
}

+(void)defaultSavePortalID:(NSString *)a
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"HTMIPortalID"];
    [defaults synchronize];
}



//经度
+ (NSString*)defaultLoadLongitude{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:@"location.coordinate.longitude"] ==  nil ? @"": [defaults objectForKey:@"location.coordinate.longitude"];
}
+ (void)defaultSaveLongitude:(NSString *)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"location.coordinate.longitude"];
    [defaults synchronize];
}

//纬度
+ (NSString*)defaultLoadLatitude{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:@"location.coordinate.latitude"] ==  nil ? @"": [defaults objectForKey:@"location.coordinate.latitude"];
}
+ (void)defaultSaveLatitude:(NSString *)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"location.coordinate.latitude"];
    [defaults synchronize];
}

//第一次从数据库中获取应用中心数据
+ (BOOL)defaultLoadFirstloadAppCenterDataFromDB{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"HTMI_firstloadAppCenterDataFromDB"];
}
+ (void)defaultSaveFirstloadAppCenterDataFromDB:(BOOL)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:a forKey:@"HTMI_firstloadAppCenterDataFromDB"];
    [defaults synchronize];
}

//工作圈第一次使用
+ (BOOL)defaultLoadCircleFirstStart{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults] ;
    return [defaults boolForKey:@"circleFirstStart"];
}
+ (void)defaultSaveCircleFirstStart:(BOOL)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:a  forKey:@"circleFirstStart"];
    [defaults synchronize];
}

//应用中心第一次使用
+ (BOOL)defaultLoadAppCenterFirstStart{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"appCenterFirstStart"];
}
+ (void)defaultSaveAppCenterFirstStart:(BOOL)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:a  forKey:@"appCenterFirstStart"];
    [defaults synchronize];
}

//工作流构件第一次使用
+ (BOOL)defaultLoadWorkFlowComponentFirstStart{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults] ;
    return [defaults boolForKey:@"workFlowComponentFirstStart"];
}
+ (void)defaultSaveWorkFlowComponentFirstStart:(BOOL)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:a  forKey:@"workFlowComponentFirstStart"];
    [defaults synchronize];
}

//流程第一次使用
+ (BOOL)defaultLoadMatterFlowFirstStart{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults] ;
    return [defaults boolForKey:@"matterFlowFirstStart"];
}
+ (void)defaultSaveMatterFlowFirstStart:(BOOL)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:a  forKey:@"matterFlowFirstStart"];
    [defaults synchronize];
}

//应用程序第一次使用
+ (BOOL)defaultLoadSystemFirstStart {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"firstStartMXApp"];
}

+ (void)defaultSaveSystemFirstStart:(BOOL)a {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:a  forKey:@"firstStartMXApp"];
    [defaults synchronize];
}

//密码
+ (NSString *)defaultLoadPassWord{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"HTMIUserPassWord"]  ==  nil ? @"": [defaults objectForKey:@"HTMIUserPassWord"];
}
+ (void)defaultSavePassWord:(NSString *)a{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"HTMIUserPassWord"];
    [defaults synchronize];
}

//
+(void)defaultSaveFontEditePageCoefficient:(NSInteger )coefficient{
    
    [USERDEFAULT setInteger:coefficient forKey:@"FontEditePageCoefficient"];
    [USERDEFAULT synchronize];
}
//
+(NSInteger)defaultLoadFontEditePageCoefficient{
    return  [USERDEFAULT integerForKey:@"FontEditePageCoefficient"];
}

+(void)clearCache{
    //清除时间戳，会重新同步本地数据库
    [HTMIUserdefaultHelper defaultSaveAddressBookSynchronizationeventStamp:@""];
    
    [HTMIUserdefaultHelper defaultSaveContext:@{}];
    [HTMIUserdefaultHelper defaultSaveUserID:@""];
    [HTMIUserdefaultHelper defaultSaveOAUserID:@""];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"HTMIPortalID"];//men
    [userDefaults removeObjectForKey:@"htmi_AppId"];
    [userDefaults removeObjectForKey:@"fengge"];
    [userDefaults removeObjectForKey:@"location.coordinate.latitude"];
    [userDefaults removeObjectForKey:@"location.coordinate.longitude"];
    [userDefaults removeObjectForKey:@"HTMI_firstloadAppCenterDataFromDB"];
    [userDefaults removeObjectForKey:@"circleFirstStart"];
    [userDefaults removeObjectForKey:@"appCenterFirstStart"];
    [userDefaults removeObjectForKey:@"workFlowComponentFirstStart"];
    [userDefaults removeObjectForKey:@"matterFlowFirstStart"];
    [userDefaults removeObjectForKey:@"HTMILoginName"];
    
    [userDefaults synchronize];
    //[userDefaults removeObjectForKey:@"htmi_IsEMIUser"]; 这个不能清空，因为退出是依靠这个字段判断使用敏行的退出方法还是直接使用我们自己的退出方法
}

//临时账号
+ (NSString *)defaultLoadTempLoginName{
    
    return [USERDEFAULT objectForKey:@"HTMITempLoginName"];
}

//临时账号
+ (void)defaultSaveTempLoginName:(NSString *)a {
    [USERDEFAULT setObject:a forKey:@"HTMITempLoginName"];
    [USERDEFAULT synchronize];
}

//账号
+ (NSString *)defaultLoadLoginName{
    
    return [USERDEFAULT objectForKey:@"HTMILoginName"];
}
+ (void)defaultSaveLoginName:(NSString *)a{
    [USERDEFAULT setObject:a forKey:@"HTMILoginName"];
    [USERDEFAULT synchronize];
}
+ (void)removeHTMIUserDefaultValueForloginName{
    
    [USERDEFAULT removeObjectForKey:@"HTMILoginName"];
}



/**
 正文
 */
+(NSString *)defaultLoadBodyFile{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"htmi_BodyFilePath"] ==  nil ? @"": [defaults objectForKey:@"htmi_BodyFilePath"];
}
+(void)defaultSaveBodyFile:(NSString *)a{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:a  forKey:@"htmi_BodyFilePath"];
    [defaults synchronize];
}

@end
