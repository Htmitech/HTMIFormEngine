//
//  HTMIPickerView.m
//  testPickerView
//
//  Created by chong on 16/7/8.
//  Copyright © 2016年 chong. All rights reserved.
//

#import "HTMIPickerView.h"

#import "HTMISettingManager.h"

#import "UtilsMacros.h"

#import "UIFont+HTMIFont.h"

@interface HTMIPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *myPickerView;
    NSMutableArray *_proYearList;
    NSMutableArray *_proMonthList;
    NSMutableArray *_proDayList;
    NSMutableArray *_proHoursList;
    NSMutableArray *_proMinutesList;
    NSMutableArray *_proWeekList;
    NSInteger pickerTypeInteger;
    NSArray *_morningAndAfternoon;
    NSString *my_Year;
    NSString *my_Month;
    NSString *my_Day;
    NSString *my_hour;
    NSString *my_Minute;
    NSString *my_week;
    NSString *my_morningandafternoon;
    
    UILabel *myTimeLabel;
}
//取消 确定  放置位置
@property (nonatomic, strong) UIToolbar *mytoolBarAction;

@end

@implementation HTMIPickerView


-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/*
 myYear,             //年
 myYearMonth,        //年月
 myYearMonthDay,     //年月日
 myAlldate,          //年月日时分
 */
-(instancetype)initWithFrame:(CGRect)frame myselecttype:(myDateENUM)pickerString andmyBackColor:(UIColor *)backColor andmyCellBackClolr:(UIColor *)cellBackColor andpersonInfoDate:(NSString *)myInfoDate{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = backColor;
        [self setMytoolBarAction:self.mytoolBarAction];
        [self makeSureAndCancleButtonAndLabelTime];
        if (pickerString == myYear) {
            [self myYearsrequest];
            pickerTypeInteger = 1;
        }else if (pickerString == myYearMonth){
            [self myYearsrequest];
            [self myMonthrequest];
            pickerTypeInteger = 2;
        }else if (pickerString == myYearMonthDay){
            [self myYearsrequest];
            [self myMonthrequest];
            _proDayList = [NSMutableArray array];
            [self myDayrequest:[NSDate date]];
            pickerTypeInteger = 3;
        }else if (pickerString == myAlldate){
            [self myYearsrequest];
            [self myMonthrequest];
            _proDayList = [NSMutableArray array];
            [self myDayrequest:[NSDate date]];
            [self myHoursrequest];
            [self myMinutesrequest];
            pickerTypeInteger = 4;
        }else if (pickerString == myWeek){
            [self myYearsrequest];
            [self myWeekrequest];
            pickerTypeInteger = 5;
        }else if (pickerString == myYearMonthDaymorningAndAfternoon){
            
            [self myYearsrequest];
            [self myMonthrequest];
            _proDayList = [NSMutableArray array];
            [self myDayrequest:[NSDate date]];
            [self mymorningAndAfternoonrequest];
            pickerTypeInteger = 6;
        }
        // 选择框
        myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kH6(45), frame.size.width, frame.size.height-kH6(45))];
        // 显示选中框
        myPickerView.showsSelectionIndicator = YES;
        myPickerView.dataSource = self;
        myPickerView.delegate = self;
        myPickerView.backgroundColor = backColor;
        [self addSubview:myPickerView];
        int framex = frame.size.height/2-29;
        UIImageView *selectionCenterView=[[UIImageView alloc]initWithFrame:CGRectMake(0, framex, frame.size.width, 27)];
        selectionCenterView.backgroundColor = cellBackColor;
        selectionCenterView.alpha=0.5;
        [myPickerView addSubview:selectionCenterView];
        
        
        [self defaultTime:myInfoDate];
    }
    return self;
}

#pragma mark 年份
-(void)myYearsrequest{
    _proYearList = [NSMutableArray array];
    for (int i = 1970; i < 2100; i++) {
        [_proYearList addObject:[NSString stringWithFormat:@"%d年",i]];
    }
}
#pragma mark 月份
-(void)myMonthrequest{
    _proMonthList = [[NSMutableArray alloc]initWithObjects:@"01月",@"02月",@"03月",@"04月",@"05月",@"06月",@"07月",@"08月",@"09月",@"10月",@"11月",@"12月",nil];
}
#pragma mark 天数
-(void)myDayrequest:(NSDate *)myDate{
    NSInteger myInteger = [self numberOfDaysInMonth:myDate];
    for (int i = 1; i < myInteger+1; i++) {
        if (i < 10) {
            [_proDayList addObject:[NSString stringWithFormat:@"0%d日",i]];
        }else{
            [_proDayList addObject:[NSString stringWithFormat:@"%d日",i]];
        }
        
    }
}
#pragma mark 小时
-(void)myHoursrequest{
    _proHoursList = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
        if (i < 10) {
            [_proHoursList addObject:[NSString stringWithFormat:@"0%d时",i]];
        }else{
            [_proHoursList addObject:[NSString stringWithFormat:@"%d时",i]];
        }
        
    }
}
#pragma mark 分钟
-(void)myMinutesrequest{
    _proMinutesList = [NSMutableArray array];
    for (int i = 0; i < 60; i++) {
        if (i < 10) {
            [_proMinutesList addObject:[NSString stringWithFormat:@"0%d分",i]];
        }else{
            [_proMinutesList addObject:[NSString stringWithFormat:@"%d分",i]];
        }
    }
}
#pragma mark 周
-(void)myWeekrequest{
    _proWeekList = [NSMutableArray array];
    for (int i = 1; i < 53; i++) {
        [_proWeekList addObject:[NSString stringWithFormat:@"第%d周",i]];
    }
}
- (void)mymorningAndAfternoonrequest{
    _morningAndAfternoon = @[@"上午",@"下午"];
}
#pragma mark NSString 转 date
-(NSDate *)ismydays:(NSString *)dateString{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate* inputDate;
    inputDate = [inputFormatter dateFromString:dateString];
    
    return inputDate;
}
#pragma mark 获取某个月份一共有多少天
-(NSInteger )numberOfDaysInMonth:(NSDate *)myDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:myDate];
    NSUInteger numberOfDaysInMonth = range.length;
    
    return numberOfDaysInMonth;
}
#pragma mark 默认显示时间以及样式
-(void)defaultTime:(NSString *)timedate{
    
    NSDate *date = nil;
    if (timedate && timedate.length > 0) {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];//HHmmss
        date = [inputFormatter dateFromString:timedate];
    }else{
        date = [NSDate date];
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitWeekOfYear;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    
    NSInteger year = [dateComponents year];
    NSInteger month = [dateComponents month];
    NSInteger day = [dateComponents day];
    NSInteger hour = [dateComponents hour];
    NSInteger minute = [dateComponents minute];
    NSInteger week = [dateComponents weekOfYear];
    my_Year = [NSString stringWithFormat:@"%d年",(int)year];
    
    if (month < 10) {
        my_Month = [NSString stringWithFormat:@"0%d月",(int)month];
    }else{
        my_Month = [NSString stringWithFormat:@"%d月",(int)month];
    }
    if (day < 10) {
        my_Day = [NSString stringWithFormat:@"0%d日",(int)day];
    }else{
        my_Day = [NSString stringWithFormat:@"%d日",(int)day];
    }
    if (hour < 10) {
       my_hour = [NSString stringWithFormat:@"0%d时",(int)hour];
    }else{
        my_hour = [NSString stringWithFormat:@"%d时",(int)hour];
    }
    if (minute < 10) {
        my_Minute = [NSString stringWithFormat:@"0%d分",(int)minute];
    }else{
        my_Minute = [NSString stringWithFormat:@"%d分",(int)minute];
    }
    
    my_week = [NSString stringWithFormat:@"第%d周",(int)week];
    my_morningandafternoon = @"上午";
    if (pickerTypeInteger == 1) {
        [myPickerView selectRow:year-1970 inComponent:0 animated:NO];
        myTimeLabel.text = [NSString stringWithFormat:@"%@",my_Year];
    }else if (pickerTypeInteger == 2){
        [myPickerView selectRow:year-1970 inComponent:0 animated:NO];
        [myPickerView selectRow:month-1+12*100 inComponent:1 animated:NO];
        myTimeLabel.text = [NSString stringWithFormat:@"%@%@",my_Year,my_Month];
    }else if (pickerTypeInteger == 3){
        [myPickerView selectRow:year-1970 inComponent:0 animated:NO];
        [myPickerView selectRow:month-1+12*100 inComponent:1 animated:NO];
        [myPickerView selectRow:day-1+_proDayList.count*100 inComponent:2 animated:NO];
        myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@",my_Year,my_Month,my_Day];
    }else if (pickerTypeInteger == 4){
        [myPickerView selectRow:year-1970 inComponent:0 animated:NO];
        [myPickerView selectRow:month-1+12*100 inComponent:1 animated:NO];
        [myPickerView selectRow:day-1+_proDayList.count*100 inComponent:2 animated:NO];
        [myPickerView selectRow:hour+_proHoursList.count*100 inComponent:3 animated:NO];
        [myPickerView selectRow:minute+_proMinutesList.count*100 inComponent:4 animated:NO];
        myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",my_Year,my_Month,my_Day,my_hour,my_Minute];
    }else if (pickerTypeInteger == 5){
        [myPickerView selectRow:year-1970 inComponent:0 animated:NO];
        [myPickerView selectRow:week+_proWeekList.count*100 inComponent:1 animated:NO];
        myTimeLabel.text = [NSString stringWithFormat:@"%@%@",my_Year,my_week];
    }else if (pickerTypeInteger == 6){
        [myPickerView selectRow:year-1970 inComponent:0 animated:NO];
        [myPickerView selectRow:month-1+12*100 inComponent:1 animated:NO];
        [myPickerView selectRow:day-1+_proDayList.count*100 inComponent:2 animated:NO];
        [myPickerView selectRow:0 inComponent:3 animated:NO];
        myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@  %@",my_Year,my_Month,my_Day,my_morningandafternoon];
    }
}

#pragma mark pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerTypeInteger == 1) {
        return 1;
    }else if (pickerTypeInteger == 2){
        return 2;
    }else if (pickerTypeInteger == 3){
        return 3;
    }else if (pickerTypeInteger == 4){
        return 5;
    }else if (pickerTypeInteger == 5){
        return 2;
    }else if (pickerTypeInteger == 6){
        return 4;
    }
    return 0;
}

#pragma mark pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerTypeInteger == 1) {
        if (component == 0) {
            return _proYearList.count;
        }
    }else if (pickerTypeInteger == 2){
        if (component == 0) {
            return _proYearList.count;
        }else if (component == 1) {
            return _proMonthList.count * 200;
        }
    }else if (pickerTypeInteger == 3){
        if (component == 0) {
            return _proYearList.count;
        }else if (component == 1) {
            return _proMonthList.count * 200;
        }else{
            return _proDayList.count * 200;
        }
    }else if (pickerTypeInteger == 4){
        if (component == 0) {
            return _proYearList.count;
        }else if (component == 1) {
            return _proMonthList.count * 200;
        }else if (component == 2){
            return _proDayList.count * 200;
        }else if (component == 3){
            return _proHoursList.count * 200;
        }else if (component == 4){
            return _proMinutesList.count * 200;
        }
    }else if (pickerTypeInteger == 5){
        if (component == 0) {
            return _proYearList.count;
        }else if (component == 1) {
            return _proWeekList.count * 200;
        }
    }else if (pickerTypeInteger == 6){
        if (component == 0) {
            return _proYearList.count;
        }else if (component == 1) {
            return _proMonthList.count * 200;
        }else if (component == 2) {
            return _proDayList.count * 200;
        }else{
            return 2;
        }
    }
    return 0;
}
#pragma mark 调整字体显示大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = [UIFont htmi_systemFontOfSize:8.0];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (pickerTypeInteger == 1) {
        if (component == 0) {
            return 80;
        }
    }else if (pickerTypeInteger == 2){
        if (component == 0) {
            return 80;
        }else if (component == 1) {
            return 60;
        }
    }else if (pickerTypeInteger == 3){
        if (component == 0) {
            return 80;
        }else if (component == 1) {
            return 60;
        }else if (component == 2){
            return 60;
        }
    }else if (pickerTypeInteger == 4){
        if (component == 0) {
            return 60;
        }else if (component == 1) {
            return 30;
        }else if (component == 2){
            return 40;
        }else if (component == 3){
            return 30;
        }else if (component == 4){
            return 30;
        }
    }else if (pickerTypeInteger == 5){
        if (component == 0) {
            return 80;
        }else if (component == 1) {
            return 60;
        }
    }else if (pickerTypeInteger == 6){
        if (component == 0) {
            return 80;
        }else if (component == 1) {
            return 60;
        }else if (component == 2){
            return 60;
        }else if (component == 3){
            return 60;
        }
    }
    return 60;
}

#pragma mark 返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerTypeInteger == 1) {
        if (component == 0) {
            return [_proYearList objectAtIndex:(row%[_proYearList count])];
        }
    }else if (pickerTypeInteger == 2){
        if (component == 0) {
            return [_proYearList objectAtIndex:(row%[_proYearList count])];
        }else
            if (component == 1) {
                return [_proMonthList objectAtIndex:(row%[_proMonthList count])];
            }
    }else if (pickerTypeInteger == 3){
        if (component == 0) {
            return [_proYearList objectAtIndex:(row%[_proYearList count])];
        }else if (component == 1) {
            return [_proMonthList objectAtIndex:(row%[_proMonthList count])];
        } else if (component == 2){
            return [_proDayList objectAtIndex:(row%[_proDayList count])];
        }
    }else if (pickerTypeInteger == 4){
        if (component == 0) {
            return [_proYearList objectAtIndex:(row%[_proYearList count])];
        }else if (component == 1) {
            return [_proMonthList objectAtIndex:(row%[_proMonthList count])];
        }else if (component == 2){
            return [_proDayList objectAtIndex:(row%[_proDayList count])];
        }else if (component == 3){
            return [_proHoursList objectAtIndex:(row%[_proHoursList count])];
        }else if (component == 4){
            return [_proMinutesList objectAtIndex:(row%[_proMinutesList count])];
        }
    }else if (pickerTypeInteger == 5){
        if (component == 0) {
            return [_proYearList objectAtIndex:(row%[_proYearList count])];
        }else
        if (component == 1) {
            return [_proWeekList objectAtIndex:(row%[_proWeekList count])];
        }
    }else if (pickerTypeInteger == 6){
        if (component == 0) {
            return [_proYearList objectAtIndex:(row%[_proYearList count])];
        }else if (component == 1) {
            return [_proMonthList objectAtIndex:(row%[_proMonthList count])];
        } else if (component == 2){
            return [_proDayList objectAtIndex:(row%[_proDayList count])];
        }else if (component == 3){
            return [_morningAndAfternoon objectAtIndex:row];
        }
    }
    return nil;
}


#pragma mark 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerTypeInteger == 1) {
        if (component == 0) {
            my_Year = [_proYearList objectAtIndex:(row%[_proYearList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@",my_Year];
        }
    }else if (pickerTypeInteger == 2){
        if (component == 0) {
            my_Year = [_proYearList objectAtIndex:(row%[_proYearList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@",my_Year,my_Month];
        }else if (component == 1) {
            my_Month = [_proMonthList objectAtIndex:(row%[_proMonthList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@",my_Year,my_Month];
        }
    }else if (pickerTypeInteger == 3){
        if (component == 0) {
            my_Year = [_proYearList objectAtIndex:(row%[_proYearList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@",my_Year,my_Month,my_Day];
            
            [_proDayList removeAllObjects];
            NSString *myStr = [NSString stringWithFormat:@"%@%@%@",my_Year,my_Month,my_Day];
            NSDate *myDate1;
            myDate1 = [self ismydays:myStr];
            if (!myDate1) {
                NSString *myStr1 = [NSString stringWithFormat:@"%@%@01日",my_Year,my_Month];
                my_Day = @"01日";
                myDate1 = [self ismydays:myStr1];
            }
            [self myDayrequest:myDate1];
            NSString*day01 =[my_Day stringByReplacingOccurrencesOfString:@"日" withString:@""];
            int dayInt = [[NSString stringWithFormat:@"%@",day01]intValue];
            if (component != 2) {
                [myPickerView selectRow:dayInt-1+_proDayList.count*100 inComponent:2 animated:NO];
            }
            
        }else if (component == 1) {
            my_Month = [_proMonthList objectAtIndex:(row%[_proMonthList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@",my_Year,my_Month,my_Day];
            
            [_proDayList removeAllObjects];
            NSString *myStr = [NSString stringWithFormat:@"%@%@%@",my_Year,my_Month,my_Day];
            NSDate *myDate1;
            myDate1 = [self ismydays:myStr];
            if (!myDate1) {
                NSString *myStr1 = [NSString stringWithFormat:@"%@%@01日",my_Year,my_Month];
                my_Day = @"01日";
                myDate1 = [self ismydays:myStr1];
            }
            [self myDayrequest:myDate1];
            NSString*day01 =[my_Day stringByReplacingOccurrencesOfString:@"日" withString:@""];
            int dayInt = [[NSString stringWithFormat:@"%@",day01]intValue];
            if (component != 2) {
                [myPickerView selectRow:dayInt-1+_proDayList.count*100 inComponent:2 animated:NO];
            }
            
        }else if(component == 2){
            my_Day = [_proDayList objectAtIndex:(row%[_proDayList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@",my_Year,my_Month,my_Day];
        }
    }else if (pickerTypeInteger == 4){
        if (component == 0) {
            my_Year = [_proYearList objectAtIndex:(row%[_proYearList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",my_Year,my_Month,my_Day,my_hour,my_Minute];
            
            [_proDayList removeAllObjects];
            NSString *myStr = [NSString stringWithFormat:@"%@%@%@",my_Year,my_Month,my_Day];
            NSDate *myDate1;
            myDate1 = [self ismydays:myStr];
            if (!myDate1) {
                NSString *myStr1 = [NSString stringWithFormat:@"%@%@01日",my_Year,my_Month];
                my_Day = @"01日";
                myDate1 = [self ismydays:myStr1];
            }
            [self myDayrequest:myDate1];
            NSString*day01 =[my_Day stringByReplacingOccurrencesOfString:@"日" withString:@""];
            int dayInt = [[NSString stringWithFormat:@"%@",day01]intValue];
            if (component != 2) {
                [myPickerView selectRow:dayInt-1+_proDayList.count*100 inComponent:2 animated:NO];
            }
            
        }else if (component == 1) {
            my_Month = [_proMonthList objectAtIndex:(row%[_proMonthList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",my_Year,my_Month,my_Day,my_hour,my_Minute];
            [_proDayList removeAllObjects];
            NSString *myStr = [NSString stringWithFormat:@"%@%@%@",my_Year,my_Month,my_Day];
            NSDate *myDate1;
            myDate1 = [self ismydays:myStr];
            if (!myDate1) {
                NSString *myStr1 = [NSString stringWithFormat:@"%@%@01日",my_Year,my_Month];
                my_Day = @"01日";
                myDate1 = [self ismydays:myStr1];
            }
            [self myDayrequest:myDate1];
            NSString*day01 =[my_Day stringByReplacingOccurrencesOfString:@"日" withString:@""];
            int dayInt = [[NSString stringWithFormat:@"%@",day01]intValue];
            if (component != 2) {
                [myPickerView selectRow:dayInt-1+_proDayList.count*100 inComponent:2 animated:NO];
            }
        }else if(component == 2){
            my_Day = [_proDayList objectAtIndex:(row%[_proDayList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",my_Year,my_Month,my_Day,my_hour,my_Minute];
        }else if(component == 3){
            my_hour = [_proHoursList objectAtIndex:(row%[_proHoursList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",my_Year,my_Month,my_Day,my_hour,my_Minute];
        }else if(component == 4){
            my_Minute = [_proMinutesList objectAtIndex:(row%[_proMinutesList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",my_Year,my_Month,my_Day,my_hour,my_Minute];
        }
    }else if (pickerTypeInteger == 5){
        if (component == 0) {
            my_Year = [_proYearList objectAtIndex:(row%[_proYearList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@",my_Year,my_week];
        }else if (component == 1) {
            my_week = [_proWeekList objectAtIndex:(row%[_proWeekList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@",my_Year,my_week];
        }
    }else if (pickerTypeInteger == 6){
        if (component == 0) {
            my_Year = [_proYearList objectAtIndex:(row%[_proYearList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@  %@",my_Year,my_Month,my_Day,my_morningandafternoon];
            
            [_proDayList removeAllObjects];
            NSString *myStr = [NSString stringWithFormat:@"%@%@%@",my_Year,my_Month,my_Day];
            NSDate *myDate1;
            myDate1 = [self ismydays:myStr];
            if (!myDate1) {
                NSString *myStr1 = [NSString stringWithFormat:@"%@%@01日",my_Year,my_Month];
                my_Day = @"01日";
                myDate1 = [self ismydays:myStr1];
            }
            [self myDayrequest:myDate1];
            NSString*day01 =[my_Day stringByReplacingOccurrencesOfString:@"日" withString:@""];
            int dayInt = [[NSString stringWithFormat:@"%@",day01]intValue];
            if (component != 2) {
                [myPickerView selectRow:dayInt-1+_proDayList.count*100 inComponent:2 animated:NO];
            }
            
        }else if (component == 1) {
            my_Month = [_proMonthList objectAtIndex:(row%[_proMonthList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@  %@",my_Year,my_Month,my_Day,my_morningandafternoon];
            
            [_proDayList removeAllObjects];
            NSString *myStr = [NSString stringWithFormat:@"%@%@%@",my_Year,my_Month,my_Day];
            NSDate *myDate1;
            myDate1 = [self ismydays:myStr];
            if (!myDate1) {
                NSString *myStr1 = [NSString stringWithFormat:@"%@%@01日",my_Year,my_Month];
                my_Day = @"01日";
                myDate1 = [self ismydays:myStr1];
            }
            [self myDayrequest:myDate1];
            NSString*day01 =[my_Day stringByReplacingOccurrencesOfString:@"日" withString:@""];
            int dayInt = [[NSString stringWithFormat:@"%@",day01]intValue];
            if (component != 2) {
                [myPickerView selectRow:dayInt-1+_proDayList.count*100 inComponent:2 animated:NO];
            }
            
        }else if(component == 2){
            my_Day = [_proDayList objectAtIndex:(row%[_proDayList count])];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@  %@",my_Year,my_Month,my_Day,my_morningandafternoon];
        }else if(component == 3){
            my_morningandafternoon = [_morningAndAfternoon objectAtIndex:row];
            myTimeLabel.text = [NSString stringWithFormat:@"%@%@%@  %@",my_Year,my_Month,my_Day,my_morningandafternoon];
        }
    }
}



//#pragma mark ------ 取消 确定  放置位置toolBar
//-(UIToolbar *)mytoolBarAction{
//    if (!_mytoolBarAction) {
//        _mytoolBarAction = [[UIToolbar alloc] initWithFrame:self.bounds];
//        _mytoolBarAction.tintColor = [UIColor blackColor];
//        _mytoolBarAction.barTintColor = [UIColor greenColor];
//        [self addSubview:_mytoolBarAction];
//    }
//    return _mytoolBarAction;
//}
#pragma mark ------ 确定 、 取消 按钮
- (void)makeSureAndCancleButtonAndLabelTime {
    NSArray *array = @[@"取消",@"确定"];
    UIButton *mscButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    mscButton1.frame = CGRectMake(0, 5, kW6(60), kH6(45));
    [mscButton1 setTitle:array[0] forState:UIControlStateNormal];
    [mscButton1 setTitleColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0] forState:UIControlStateNormal];
    mscButton1.titleLabel.font = [UIFont htmi_systemFontOfSize:15];
    mscButton1.backgroundColor = [UIColor clearColor];
    mscButton1.tag = 0;
    [mscButton1 addTarget:self action:@selector(makeSureAndCancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mscButton1];
    
    UIButton *mscButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    mscButton2.frame = CGRectMake(kScreenWidth-kW6(60), 5, kW6(60), kH6(45));
    [mscButton2 setTitle:array[1] forState:UIControlStateNormal];
    if (kApplicationHue == HTMIApplicationHueWhite) {//白色色调
        [mscButton2 setTitleColor:[UIColor colorWithRed:41/255.0 green:123/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateNormal];
    } else {
        [mscButton2 setTitleColor:navBarColor forState:UIControlStateNormal];
    }
    
    mscButton2.titleLabel.font = [UIFont htmi_systemFontOfSize:15];
    mscButton2.backgroundColor = [UIColor clearColor];
    mscButton2.tag = 1;
    [mscButton2 addTarget:self action:@selector(makeSureAndCancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mscButton2];
    
    myTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kW6(60), 5, kScreenWidth-kW6(120), kH6(45))];
    myTimeLabel.font = [UIFont htmi_systemFontOfSize:15];
    myTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:myTimeLabel];
    UIImageView *myImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    myImg.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    [self addSubview:myImg];
    
}

- (void)makeSureAndCancleButtonClick:(UIButton *)btn {
    
    if (btn.tag == 1) {
        if (pickerTypeInteger == 1) {
            NSString*myYear =[my_Year stringByReplacingOccurrencesOfString:@"年" withString:@""];
            self.myPickerBlockString([NSString stringWithFormat:@"%@",myYear]);
        }else if (pickerTypeInteger == 2) {
            NSString*myYear =[my_Year stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
            NSString*myMonth =[my_Month stringByReplacingOccurrencesOfString:@"月" withString:@""];
            self.myPickerBlockString([NSString stringWithFormat:@"%@%@",myYear,myMonth]);
        }else if (pickerTypeInteger == 3) {
            NSString*myYear =[my_Year stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
            NSString*myMonth =[my_Month stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
            NSString*myday =[my_Day stringByReplacingOccurrencesOfString:@"日" withString:@""];
            self.myPickerBlockString([NSString stringWithFormat:@"%@%@%@",myYear,myMonth,myday]);
        }else if (pickerTypeInteger == 4) {
            NSString*myYear =[my_Year stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
            NSString*myMonth =[my_Month stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
            NSString*myday =[my_Day stringByReplacingOccurrencesOfString:@"日" withString:@""];
            NSString*myhour =[my_hour stringByReplacingOccurrencesOfString:@"时" withString:@":"];
            NSString*myMinute =[my_Minute stringByReplacingOccurrencesOfString:@"分" withString:@""];
            self.myPickerBlockString([NSString stringWithFormat:@"%@%@%@ %@%@:00",myYear,myMonth,myday,myhour,myMinute]);
        }else if (pickerTypeInteger == 5) {
            NSString*myYear =[my_Year stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
            NSString*myweek =[my_week stringByReplacingOccurrencesOfString:@"月" withString:@""];
            self.myPickerBlockString([NSString stringWithFormat:@"%@%@",myYear,myweek]);
        }else if (pickerTypeInteger == 6) {
            NSString*myYear =[my_Year stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
            NSString*myMonth =[my_Month stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
            NSString*myday =[my_Day stringByReplacingOccurrencesOfString:@"日" withString:@""];
            self.myPickerBlockString([NSString stringWithFormat:@"%@%@%@ %@",myYear,myMonth,myday,my_morningandafternoon]);
        }

    } else {
        self.myPickerBlockString(@"");
    }

    [self.delegate myresignFirstResponder];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
