//
//  HTMIFormTimeView.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormTimeView.h"

#import "HTMISupportCopyLabel.h"

#import "HTMIFormComponentHeader.h"

#import "NSString+HTMISize.h"

//#import "UIView+Common.h"

#import "HTMIPickerView.h"

#import "UITableViewCell+GetCell.h"

#import "Masonry.h"
#import "HTMIStandardAjaxEventModel.h"

#import "UIFont+HTMIFont.h"

#import "UIView+BorderView.h"

#import "HTMITabFormModel.h"

@interface HTMIFormTimeView ()

@property (nonatomic, strong) HTMIPickerView *datePicker;

@end

@implementation HTMIFormTimeView


#pragma mark ------ 时间选择（内容）
- (void)inputTypeFieldItem:(HTMIFieldItemModel *)fieldItem name:(NSString *)nameString value:(NSString *)valueString width:(CGFloat)itemWidth totalView:(UIView *)view cellHeight:(CGFloat)cellHeight {
    
    [view addSubview:self];
    self.frame = view.bounds;
    
    BOOL isMustinput = fieldItem.mustInput;
    
    if ((![self.fieldItemModel.modeString isEqual:[NSNull null]] && [self.fieldItemModel.modeString isEqualToString:@"1"])) {
        
        if (self.tabFormModel.tabStyle == 0) {
            //表格式表单
            
            CGRect timeRect = CGRectMake(borderLeftWidth,
                                         borderTopHeight,
                                         itemWidth-borderLeftWidth*2,
                                         cellHeight-borderTopHeight*2);
            
            if (fieldItem.nameVisible) {
                
                if (fieldItem.nameRN) {//显示name且分行显示
                    
                    CGFloat nameHeight = nameString.length>0 ? [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:nameString FontOfSize:self.formLabelFont].height+stringTopHeight*2 : 0;
                    
                    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, nameHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:namelabel];
                    
                    timeRect.origin.y += nameHeight;
                    timeRect.size.height -= nameHeight;
                    
                    
                } else {//显示name不分行
                    
                    CGFloat nameWidth = [NSString labelSizeWithMaxWidth:0 content:nameString FontOfSize:self.formLabelFont].width;
                    
                    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, nameWidth, cellHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:namelabel];
                    
                    timeRect.origin.x += (nameWidth+stringLeftWidth);
                    timeRect.size.width -= (nameWidth+stringLeftWidth);
                    
                }
                
            } else {//不显示name
                
            }
            
            [self originalFormCreatTimeSelectViewFrame:timeRect superView:view valueString:self.valueString isMustInput:isMustinput];
            
        } else {
            //互联网表单时间
            [self netWorkTimeSelectView:view];
            
        }
    } else {
        if (self.tabFormModel.tabStyle == 1) {
            fieldItem.alignString = @"Left";
            
            if (NO) {//self.scheduleFormNetWorkStyle
                
                CGRect nameRect = CGRectMake(stringLeftWidth, 0, kScreenWidth*0.3-stringLeftWidth*2, cellHeight);
                CGRect valueRect = CGRectMake(kScreenWidth*0.3, 0, kScreenWidth*0.7, cellHeight);
                
                HTMISupportCopyLabel *nameLabel = [[HTMISupportCopyLabel alloc] initWithFrame:nameRect];
                nameLabel.text = self.nameString;
                nameLabel.textAlignment = NSTextAlignmentLeft;
                nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
                nameLabel.font = [UIFont htmi_systemFontOfSize:self.formLabelFont];
                nameLabel.numberOfLines = 0;
                nameLabel.adjustsFontSizeToFitWidth = YES;
                [view addSubview:nameLabel];
                
                HTMISupportCopyLabel *valueLabel = [[HTMISupportCopyLabel alloc] initWithFrame:valueRect];
                valueLabel.text = self.valueString;
                valueLabel.textAlignment = NSTextAlignmentLeft;
                valueLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
                valueLabel.font = [UIFont htmi_systemFontOfSize:self.formLabelFont];
                valueLabel.numberOfLines = 0;
                valueLabel.adjustsFontSizeToFitWidth = YES;
                [view addSubview:valueLabel];
            } else {
                [HTMISupportCopyLabel inputNoEditFieldItem:fieldItem
                                                nameString:nameString
                                               valueString:valueString
                                                     width:itemWidth-stringLeftWidth*2
                                                cellHeight:cellHeight
                                                 superView:view
                                                  fontSize:self.formLabelFont];
            }
        } else {
            [HTMISupportCopyLabel inputNoEditFieldItem:fieldItem
                                            nameString:nameString
                                           valueString:valueString
                                                 width:itemWidth-stringLeftWidth*2
                                            cellHeight:cellHeight
                                             superView:view
                                              fontSize:self.formLabelFont];
        }
    }
}

- (void)creatTimeSelectViewFrame:(CGRect)frame superView:(UIView *)superView valueString:(NSString *)valueString isMustInput:(BOOL)isMustinput {
    
    if (/* DISABLES CODE */ (YES)) {
        
    }
    else {
        [self originalFormCreatTimeSelectViewFrame:frame superView:superView valueString:valueString isMustInput:isMustinput];
    }
}

- (void)originalFormCreatTimeSelectViewFrame:(CGRect)frame superView:(UIView *)superView valueString:(NSString *)valueString isMustInput:(BOOL)isMustinput {
    
    UIView *borderView = [UIView creatBorderViewFrame:frame];
    borderView.tag = superView.tag;
    if (isMustinput) {
        borderView.backgroundColor = mustInputColor;
    }
    [superView addSubview:borderView];
    
    if (self.fieldItemModel.isShowMustInputWarning) {
        borderView.layer.borderColor = WARNING_BORDER_COLOR;
    } else {
        borderView.layer.borderColor = NORMAL_BORDER_COLOR;
    }
    
    UITapGestureRecognizer *timeViewClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeViewClick:)];
    timeViewClick.delegate = self;
    [borderView addGestureRecognizer:timeViewClick];
    
    HTMISupportCopyLabel *timeLabel = [[HTMISupportCopyLabel alloc] initWithFrame:CGRectMake(kW6(7), 0, W(borderView)-kW6(7)*2, H(borderView))];
    timeLabel.text = valueString;
    timeLabel.font = [UIFont htmi_systemFontOfSize:self.formLabelFont];
    timeLabel.adjustsFontSizeToFitWidth = YES;
    timeLabel.numberOfLines = 0;
    if (valueString.length<1) {
        timeLabel.text = FormGetHTMILocalString(@"htmi_common_pleasechoosetime");
        timeLabel.textColor = [UIColor lightGrayColor];
    }
    [borderView addSubview:timeLabel];
}

#pragma mark ------ 互联网表单样式
- (void)netWorkTimeSelectView:(UIView *)superView {
    CGRect valueRect = CGRectMake(0, 0, self.itemWidth, self.cellHeight);
    
    if (self.fieldItemModel.nameVisible) {
        //显示 name，固定 30% 长度
        CGRect nameRect = CGRectMake(stringLeftWidth, 0, kScreenWidth*0.3-stringLeftWidth*2, self.cellHeight);
        HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:nameRect
                                                                               text:self.nameString
                                                                          alingment:@"Left"
                                                                          textColor:self.fieldItemModel.nameFontColor
                                                                           fontSize:self.formLabelFont];
        namelabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        [superView addSubview:namelabel];
        
        valueRect.origin.x += kScreenWidth*0.3;
        valueRect.size.width -= kScreenWidth*0.3;
        
    } else {//不显示name
        
    }
    
    HTMISupportCopyLabel *valuelabel = [HTMISupportCopyLabel creatLabelWithFrame:valueRect
                                                                            text:self.valueString
                                                                       alingment:@"Left"
                                                                       textColor:self.fieldItemModel.valueFontColor
                                                                        fontSize:self.formLabelFont];
    valuelabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    [superView addSubview:valuelabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"icon_time"];
    [valuelabel addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(valuelabel).offset(-10);
        make.centerY.equalTo(valuelabel);
        make.width.height.mas_equalTo(30);
    }];
    //必填
    BOOL isMustinput = [self.fieldItemModel isMustInput:self.fieldItemModel.mustInput value:self.fieldItemModel.valueString];
    if (isMustinput) {
        valuelabel.text = [NSString stringWithFormat:@"（%@）",FormGetHTMILocalString(@"htmi_workflow_mandatory")];
        valuelabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    }
    
    valuelabel.tag = superView.tag;
    UITapGestureRecognizer *borderViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeViewClick:)];
    borderViewTap.delegate = self;
    [valuelabel addGestureRecognizer:borderViewTap];
}


- (void)timeViewClick:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(popViewDismiss)]) {
        [self.delegate popViewDismiss];
    }
    
    UITableViewCell *cell = [UITableViewCell getCellBy:tap.view];
    
    HTMIRegionCellModel *infoRegion = self.infoRegionArray[[self.matterFormTableView indexPathForCell:cell].row];
    HTMIFieldItemModel *fieldItem = infoRegion.fieldItemArray[tap.view.tag];
    
    NSDictionary *dic = @{@"300":@"2",@"301":@"3",@"302":@"0",@"303":@"1",@"304":@"4",@"305":@"5"};
    
    //    if (self.tabFormModel.tabStyle == 0) {
    self.datePicker = [[HTMIPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 216+30) myselecttype:[[dic objectForKey:self.fieldItemModel.inputString] integerValue] andmyBackColor:[UIColor whiteColor] andmyCellBackClolr:[UIColor whiteColor] andpersonInfoDate:@""];
    //    } else {
    //        self.datePicker = [[HTMIPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 216+30) myselecttype:5 andmyBackColor:[UIColor whiteColor] andmyCellBackClolr:[UIColor whiteColor] andpersonInfoDate:@""];
    //    }
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    tempView.backgroundColor = [UIColor blackColor];
    tempView.alpha = 0.5;
    [self.window addSubview:tempView];
    
    [self.window addSubview:self.datePicker];
    
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    self.datePicker.frame = CGRectMake(0, kScreenHeight-246, kScreenWidth, 216+30);
    [UIView commitAnimations];
    
    typeof(self) __weakSelf = self;
    
    typeof(self.datePicker) __weakDatePicker = self.datePicker;
    
    typeof(tempView) __weakTempView = tempView;
    
    self.datePicker.myPickerBlockString = ^(NSString *timeString) {
        
        if (timeString.length > 0) {
            
            fieldItem.valueString = timeString;
            fieldItem.isShowMustInputWarning = NO;
            
            [__weakSelf.matterFormTableView reloadData];
            
            [__weakSelf.delegate editValueChangeKey:fieldItem.keyString
                                              value:timeString
                                               mode:fieldItem.modeString
                                          inputType:fieldItem.inputString
                                            formKey:fieldItem.formkeyString
                                              isExt:fieldItem.is_ext
                                          eventType:[NSString stringWithFormat:@"%@",fieldItem.ajaxEventModel.eventType]
                                     fieldItemModel:fieldItem];
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            __weakDatePicker.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 216+30);
        } completion:^(BOOL finished) {
            [__weakDatePicker removeFromSuperview];
        }];
        [__weakTempView removeFromSuperview];
    };
}

/**
 处理Ajax事件 (需要子类实现)
 */
- (void)handleAjaxEvent:(HTMIFormChangedFieldModel *)changedFieldModel {
    
    //直接写事件的处理逻辑
    NSLog(@"%@",changedFieldModel);
    
    self.fieldItemModel.valueString = changedFieldModel.fieldValue;
    
    //    NSMutableArray *dicsMarray = [NSMutableArray array];
    //    for (NSDictionary *dict in changedFieldModel.dics) {
    //        HTMIItemDicsModel *model = [HTMIItemDicsModel getItemDicsModelWithDict:dict];
    //        [dicsMarray addObject:model];
    //    }
    self.fieldItemModel.dicsArray = [changedFieldModel.dics copy];
    
    [self.matterFormTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:self.indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    //    [self.matterFormTableView reloadData];
}

@end
