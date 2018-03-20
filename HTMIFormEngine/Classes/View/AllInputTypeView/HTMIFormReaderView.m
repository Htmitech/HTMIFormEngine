//
//  HTMIFormReaderView.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormReaderView.h"

#import "HTMIFormComponentHeader.h"

#import "NSString+HTMISize.h"

//#import "UIView+Common.h"

#import "HTMISupportCopyLabel.h"

#import "UITableViewCell+GetCell.h"

//#import "HTMIChooseFormAddressBookViewController.h"

//#import "HTMISYS_UserModel.h"

#import "Masonry.h"
#import "HTMIStandardAjaxEventModel.h"

#import "UIFont+HTMIFont.h"

#import "UIView+BorderView.h"

#import "HTMITabFormModel.h"

@implementation HTMIFormReaderView

#pragma mark ------ 读者 、 作者
- (void)inputTypeFieldItem:(HTMIFieldItemModel *)fieldItem name:(NSString *)nameString value:(NSString *)valueString width:(CGFloat)itemWidth totalView:(UIView *)view cellHeight:(CGFloat)cellHeight {
    
    [view addSubview:self];
    self.frame = view.bounds;
    
    BOOL isMustinput = fieldItem.mustInput;
    
    if ((![fieldItem.modeString isEqual:[NSNull null]] && [fieldItem.modeString isEqualToString:@"1"])) {//可编辑
        
        if (self.tabFormModel.tabStyle == 0) {
            //
            
            UIView *borderView = nil;
            CGRect borderViewRect = CGRectMake(borderLeftWidth,
                                               borderTopHeight,
                                               itemWidth-borderLeftWidth*2,
                                               cellHeight-borderTopHeight*2);
            
            if (fieldItem.nameVisible) {
                
                if (fieldItem.nameRN) {//显示name且分行显示
                    
                    CGFloat nameHeight = nameString.length>0 ? [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:nameString FontOfSize:self.formLabelFont].height+stringTopHeight*2 : 0;
                    
                    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, nameHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:namelabel];
                    
                    borderViewRect.origin.y += nameHeight;
                    borderViewRect.size.height -= nameHeight;
                    
                    
                } else {//显示name不分行
                    
                    CGFloat nameWidth = [NSString labelSizeWithMaxWidth:0 content:nameString FontOfSize:self.formLabelFont].width;
                    
                    HTMISupportCopyLabel *namelabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, nameWidth, cellHeight) text:nameString alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
                    [view addSubview:namelabel];
                    
                    borderViewRect.origin.x += (nameWidth+stringLeftWidth);
                    borderViewRect.size.width -= (nameWidth+stringLeftWidth);
                    
                }
                
            } else {//不显示name
                
            }
            
            borderView = [self creatBorderView:borderView borderRect:borderViewRect];
            
            //必填
            if (isMustinput) {
                borderView.backgroundColor = mustInputColor;
            }
            
            if (self.fieldItemModel.isShowMustInputWarning) {
                borderView.layer.borderColor = WARNING_BORDER_COLOR;
            } else {
                borderView.layer.borderColor = NORMAL_BORDER_COLOR;
            }
            
            borderView.tag = view.tag;
            UITapGestureRecognizer *borderViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecetReaderOrAuthor:)];
            borderViewTap.delegate = self;
            [borderView addGestureRecognizer:borderViewTap];
            
        } else {
            //互联网表单选人
            [self netWorkFormSelectReaderOrAuthor:view];
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

- (UIView *)creatBorderView:(UIView *)borderView borderRect:(CGRect)borderRect {
    borderView = [UIView creatBorderViewFrame:borderRect];
    [self addSubview:borderView];
    
    CGRect valueRect = CGRectMake(kW6(7), 0, W(borderView)-kW6(14), H(borderView));
    HTMISupportCopyLabel *valueLabel = [HTMISupportCopyLabel creatLabelWithFrame:valueRect
                                                                            text:self.fieldItemModel.valueString
                                                                       alingment:self.fieldItemModel.alignString
                                                                       textColor:self.fieldItemModel.valueFontColor
                                                                        fontSize:self.formLabelFont];
    if (self.fieldItemModel.valueString.length < 1) {
        if ([self.fieldItemModel.inputString isEqualToString:@"3001" ] ||
            [self.fieldItemModel.inputString isEqualToString:@"3011"]) {
            valueLabel.text = FormGetHTMILocalString(@"htmi_common_pleasechoosereader");
            valueLabel.textColor = [UIColor lightGrayColor];
        } else if (([self.fieldItemModel.inputString isEqualToString:@"3002" ] ||
                    [self.fieldItemModel.inputString isEqualToString:@"3012"])) {
            valueLabel.text = FormGetHTMILocalString(@"htmi_common_pleasechooseauthor");
            valueLabel.textColor = [UIColor lightGrayColor];
        }
    }
    [borderView addSubview:valueLabel];
    
    return borderView;
}

- (void)selecetReaderOrAuthor:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(popViewDismiss)]) {
        [self.delegate popViewDismiss];
    }
    
    UITableViewCell *cell = [UITableViewCell getCellBy:tap.view];
    HTMIRegionCellModel *infoRegion = self.infoRegionArray[[self.matterFormTableView indexPathForCell:cell].row];
    HTMIFieldItemModel *fieldItem = infoRegion.fieldItemArray[tap.view.tag];
    
    NSDictionary *dic = @{@"3001":@"1",@"3002":@"1",
                          @"3011":@"0",@"3012":@"0"};
    
    
//    HTMIChooseFormAddressBookViewController *abVC = [[HTMIChooseFormAddressBookViewController alloc] initWithChooseType:ChooseTypeUserFromAll isSingleSelection:[[dic objectForKey:fieldItem.inputString] integerValue] specificArray:nil isTree:YES];
//    [self.controller.navigationController pushViewController:abVC animated:YES];
    
    typeof(self) __weakSelf = self;
    
//    abVC.resultBlock = ^(NSArray *resultArray, NSArray *selectedRouteArray) {
//        //departmenCode = ID , UserID = value
//
//        NSMutableArray *labelTextArray = [NSMutableArray array];
//        NSMutableArray *idArray  =[NSMutableArray array];
//        NSMutableArray *valueArray = [NSMutableArray array];
//
//        for (int i = 0; i < resultArray.count; i++) {
//            HTMISYS_UserModel *userModel = resultArray[i];
//
//            [labelTextArray addObject:userModel.user_name];
//            [idArray addObject:userModel.user_id];
//            [valueArray addObject:userModel.user_id];
//        }
//        NSString *labelTextString = [labelTextArray componentsJoinedByString:@"|"];
//        NSString *idString = [idArray componentsJoinedByString:@"|"];
//        //NSString *valueString = [valueArray componentsJoinedByString:@"|"];
//
//        fieldItem.valueString = labelTextString;
//        fieldItem.isShowMustInputWarning = NO;
//
//        [self.delegate editValueChangeKey:fieldItem.keyString
//                                    value:idString
//                                     mode:fieldItem.modeString
//                                inputType:fieldItem.inputString
//                                  formKey:fieldItem.formkeyString
//                                    isExt:fieldItem.is_ext
//                                eventType:[NSString stringWithFormat:@"%@",fieldItem.ajaxEventModel.eventType]
//                           fieldItemModel:fieldItem];
//
//        [__weakSelf.matterFormTableView reloadData];
//    };
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
    self.fieldItemModel.dicsArray = changedFieldModel.dics;
    
    [self.matterFormTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:self.indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    //    [self.matterFormTableView reloadData];
}

#pragma mark ------ 互联网表单
- (void)netWorkFormSelectReaderOrAuthor:(UIView *)totalView {
    
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
        [totalView addSubview:namelabel];
        
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
    [totalView addSubview:valuelabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"icon_right_arrows"];
    [valuelabel addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(valuelabel).offset(-10);
        make.centerY.equalTo(valuelabel);
        make.width.height.mas_equalTo(40);
    }];
    
    
    //    if (self.fieldItemModel.value.length < 1) {
    //        if ([self.fieldItemModel.inputType isEqualToString:@"3001" ] ||
    //            [self.fieldItemModel.inputType isEqualToString:@"3011"]) {
    //            valuelabel.text = @"请选择读者";
    //            valuelabel.textColor = [UIColor lightGrayColor];
    //        } else if (([self.fieldItemModel.inputType isEqualToString:@"3002" ] ||
    //                    [self.fieldItemModel.inputType isEqualToString:@"3012"])) {
    //            valuelabel.text = @"请选择作者";
    //            valuelabel.textColor = [UIColor lightGrayColor];
    //        }
    //    }
    //必填
    BOOL isMustinput = [self.fieldItemModel isMustInput:self.fieldItemModel.mustInput value:self.fieldItemModel.valueString];
    if (isMustinput) {
        valuelabel.text = [NSString stringWithFormat:@"（%@）",FormGetHTMILocalString(@"htmi_workflow_mandatory")];
        
        valuelabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    }
    
    valuelabel.tag = totalView.tag;
    UITapGestureRecognizer *borderViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecetReaderOrAuthor:)];
    borderViewTap.delegate = self;
    [valuelabel addGestureRecognizer:borderViewTap];
    
}

@end
