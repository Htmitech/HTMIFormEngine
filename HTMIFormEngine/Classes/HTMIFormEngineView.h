//
//  HTMIFormView.h
//  HTMIFormComponent
//
//  Created by 赵志国 on 2018/3/16.
//  Copyright © 2018年 htmitech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

//

@class HTMITabFormModel;

@interface HTMIFormEngineView : UIView

/**
 滑动子表
 */
@property (nonatomic, strong) NSMutableArray *scrollViewArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffSetDic;

/**
 tableView 数据源
 */
@property (nonatomic, strong) NSMutableArray *infoRegionArray;


/**
 传值

 @param model HTMITabFormModel 数据源
 @param controller 控制器
 @param alpha 水印透明度
 @param formLabelFont 字体大小
 */
- (void)setTabFormModel:(HTMITabFormModel *)model controller:(UIViewController *)controller waterMarkAlpha:(CGFloat)alpha formLabelFont:(CGFloat)formLabelFont;

/**
 设置应用色调

 @param type HTMIApplicationHueType
 */
- (void)setApplicationHub:(id)type;

/**
 设置表单点击用户名聊天权限

 @param isCanChart 是否可聊天
 */
- (void)setFormUserNameChart:(BOOL)isCanChart;

/**
 刷新表单
 */
- (void)reloadFormData;

/**
 传值

 @param userName 用户名
 */
- (void)saveUserName:(NSString *)userName;

@end
