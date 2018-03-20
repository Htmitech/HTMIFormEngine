//
//  HTMIPickerView.h
//  testPickerView
//
//  Created by chong on 16/7/8.
//  Copyright © 2016年 chong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTMIPickerViewDelegate <NSObject>

-(void)myresignFirstResponder;

@end
@interface HTMIPickerView : UIView

typedef void(^mySelectPickerBlock)(NSString *myPickerString);

typedef NS_ENUM(NSInteger, myDateENUM){
    myYear = 0,         //年
    myYearMonth,        //年月
    myYearMonthDay,     //年月日
    myAlldate,          //年月日时分
    myWeek,             //年周
    myYearMonthDaymorningAndAfternoon, //年月日上午下午
};
//选择初始化时间的类型

/**
 <#Description#>

 @param frame 控件大小
 @param pickerString 时间类型
 @param backColor 背景色
 @param cellBackColor 选中背景色
 @param myInfoDate 是否显示特定时间  不填显示当前时间
 */
-(instancetype)initWithFrame:(CGRect)frame myselecttype:(myDateENUM)pickerString andmyBackColor:(UIColor *)backColor andmyCellBackClolr:(UIColor *)cellBackColor andpersonInfoDate:(NSString *)myInfoDate;
//返回给主页面的选择时间
@property (nonatomic, strong)mySelectPickerBlock myPickerBlockString;
//枚举值
@property (nonatomic,assign)myDateENUM *mydateType;

@property (nonatomic, weak)id<HTMIPickerViewDelegate> delegate;

@end
