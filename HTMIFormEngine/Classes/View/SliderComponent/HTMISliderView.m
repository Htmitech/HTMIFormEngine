//
//  HTMISliderView.m
//  单选多选
//
//  Created by 赵志国 on 16/6/16.
//  Copyright (c) 2016年 htmitech.com. All rights reserved.
//

#import "HTMISliderView.h"

//#import "HTMISelectTableViewCell.h"

#import "HTMIItemDicsModel.h"
#import "HTMIFieldItemModel.h"
#import "NSString+HTMISize.h"
#import "HTMISettingManager.h"

#import "TTRangeSlider.h"

#import "HTMISettingManager.h"

#import "HTMIApplicationHubManager.h"

@interface HTMISliderView ()<TTRangeSliderDelegate>

/**
 *  多选时存放选中数据
 */
@property (nonatomic, strong) NSMutableArray *selectedArray;

/**
 *  单选时选中行
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 *  单选时选中的按钮
 */
@property (nonatomic, strong) UIButton *selectedButton;

/**
 *  是否必填
 */
@property (nonatomic, assign) BOOL isMustInput;

/**
 *  已经选了的
 */
@property (nonatomic, copy) NSString *valueString;

/**
 滑块
 */
@property (nonatomic, strong) TTRangeSlider *rangeSlider;

/**
 字段模型
 */
@property (nonatomic, strong) HTMIFieldItemModel *fieldItemModel;

/**
 右侧的label
 */
@property (nonatomic, weak) UILabel *lowerLabel;

/**
 最小值
 */
@property (nonatomic, strong) NSNumber *minValue;

/**
 最大值
 */
@property (nonatomic, strong) NSNumber *maxValue;

@end

@implementation HTMISliderView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
               fieldItemModel:(HTMIFieldItemModel *)fieldItemModel
                   silderType:(HTMISilderType)silderType
                  isMustInput:(BOOL)isMustInput
                        value:(NSString *)valueString
                   valueLabel:(UILabel *)valueLabel
             singleValueBlock:(HTMISliderViewSingleValueBlock)singleValueBlock
                 sectionBlock:(HTMISliderViewSectionBlock)sectionBlock {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.singleValueBlock = singleValueBlock;
        self.sectionBlock = sectionBlock;
        
        self.selectedIndex = -1;
        self.fieldItemModel = fieldItemModel;
        self.silderType = silderType;
        
        if (fieldItemModel.dicsArray.count <= 0) {
            return nil;
        }
        
        for (HTMIItemDicsModel *model in fieldItemModel.dicsArray) {
            [self.idArray addObject:model.idString];
            [self.nameArray addObject:model.nameString];
            [self.valueArray addObject:model.valueString];
        }
        
        self.isMustInput = isMustInput;
        self.valueString = valueString;
        CGFloat parentViewWidth = frame.size.width;
        CGFloat parentViewHeight = frame.size.height;
        
        NSString *lblsliderstr = @"";
        
        HTMIItemDicsModel *minItemDicsModel = fieldItemModel.dicsArray.firstObject;
        HTMIItemDicsModel *maxItemDicsModel = fieldItemModel.dicsArray.lastObject;
        
        TTRangeSlider * rangeSlider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(10,10, parentViewWidth - 20, 20)];
        self.rangeSlider = rangeSlider;
        
        rangeSlider.handleColor = [HTMIApplicationHubManager manager].blueForWhiteControlColor;
        [self addSubview:rangeSlider];
        //self.rangeSlider.selectedHandleDiameterMultiplier = 1;
        self.rangeSlider.hideLabels = YES;
        self.rangeSlider.enableStep = YES;
        rangeSlider.minValue = 0.1;
        rangeSlider.maxValue = 0.1 * self.valueArray.count;
        self.rangeSlider.step = 0.1;
        self.rangeSlider.lineHeight = 1.0;
        self.rangeSlider.tintColor = [HTMIApplicationHubManager manager].blueForWhiteControlColor;
        self.rangeSlider.tintColorBetweenHandles = [HTMIApplicationHubManager manager].blueForWhiteControlColor;
        rangeSlider.delegate = self;
        
        if(silderType == HTMISilderTypeSingleValue)
        {
            rangeSlider.disableRange = YES;
            if (maxItemDicsModel) {
                
                NSString *valueString = self.valueString;
                
                if (!valueString || valueString.length <= 0) {
                    
                    valueString = minItemDicsModel.valueString;
                    self.maxValue = [NSNumber numberWithInt:[minItemDicsModel.valueString intValue]];
                    rangeSlider.selectedMinimum = [minItemDicsModel.valueString intValue] * 0.1;
                    rangeSlider.selectedMaximum = [valueString intValue] * 0.1;
                    lblsliderstr = [NSString stringWithFormat:@"%@%@",valueString,fieldItemModel.endValueString];
                }
                else {
                    rangeSlider.selectedMinimum = [minItemDicsModel.valueString intValue] * 0.1;
                    rangeSlider.selectedMaximum = [valueString intValue] * 0.1;
                    self.maxValue = [NSNumber numberWithInt:[valueString intValue]];
                    if (self.singleValueBlock) {
                        self.singleValueBlock(valueString);
                    }
                    lblsliderstr = [NSString stringWithFormat:@"%@%@",valueString,fieldItemModel.endValueString];
                }
            }
        }
        else
        {
            
            if (minItemDicsModel && maxItemDicsModel) {
                
                
                
                NSArray *selectedArray = [self.valueString componentsSeparatedByString:@"|"];
                self.selectedArray = [NSMutableArray arrayWithArray:selectedArray];
                if (self.selectedArray.count == 2) {
                    self.minValue = [NSNumber numberWithInt:[selectedArray[0] intValue]];
                    self.maxValue = [NSNumber numberWithInt:[selectedArray[1] intValue]];
                    if (self.sectionBlock) {
                        self.sectionBlock([NSString stringWithFormat:@"%d|%d",[selectedArray[0] intValue],[selectedArray[1] intValue]]);
                    }
                    
                    rangeSlider.selectedMinimum = [selectedArray[0] intValue] *0.1;
                    rangeSlider.selectedMaximum = [selectedArray[1] intValue] *0.1;
                    lblsliderstr = [NSString stringWithFormat:@"%@%@至%@%@",selectedArray[0],fieldItemModel.endValueString,selectedArray[1],fieldItemModel.endValueString];
                }
                else {
                    
                    rangeSlider.selectedMinimum = [minItemDicsModel.valueString intValue] *0.1;
                    rangeSlider.selectedMaximum = [maxItemDicsModel.valueString intValue] *0.1;
                    self.minValue = [NSNumber numberWithInt:[minItemDicsModel.valueString intValue]];
                    self.maxValue = [NSNumber numberWithInt:[maxItemDicsModel.valueString intValue]];
                    lblsliderstr = [NSString stringWithFormat:@"%@%@至%@%@",minItemDicsModel.valueString,fieldItemModel.endValueString,maxItemDicsModel.valueString,fieldItemModel.endValueString];
                }
            }
        }
        
        self.lowerLabel = valueLabel;
        self.lowerLabel.text = lblsliderstr;
    }
    
    return self;
}

#pragma mark TTRangeSliderViewDelegate
- (void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum {
    
    int minv = [[NSString stringWithFormat:@"%.1f", selectedMinimum] floatValue] * 10;
    int maxV = [[NSString stringWithFormat:@"%.1f", selectedMaximum] floatValue] * 10;
    
    NSString *lblsliderstr = @"";
    
    if(self.silderType == HTMISilderTypeSingleValue)
    {
        lblsliderstr = [NSString stringWithFormat:@"%d%@",maxV,self.fieldItemModel.endValueString];
        
        if (self.singleValueBlock) {
            
            if (self.maxValue == nil || ![[NSNumber numberWithInt:maxV] isEqualToNumber:self.maxValue]) {
                self.maxValue = [NSNumber numberWithInt:maxV];
                self.singleValueBlock([NSString stringWithFormat:@"%d",maxV]);
            }
        }
    }
    else
    {
        lblsliderstr = [NSString stringWithFormat:@"%d%@至%d%@",minv,self.fieldItemModel.endValueString,maxV,self.fieldItemModel.endValueString];
        
        if (self.sectionBlock) {
            if (self.minValue == nil || self.maxValue == nil || ![[NSNumber numberWithInt:minv] isEqualToNumber:self.minValue] || ![[NSNumber numberWithInt:maxV] isEqualToNumber:self.maxValue]) {
                
                self.minValue = [NSNumber numberWithInt:minv];
                self.maxValue = [NSNumber numberWithInt:maxV];
                self.sectionBlock([NSString stringWithFormat:@"%d|%d",minv,maxV]);
            }
        }
    }
    
    _lowerLabel.text = lblsliderstr;
}

#pragma mark ------ 懒加载
- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    
    return _selectedArray;
}

- (NSMutableArray *)idArray {
    if (!_idArray) {
        _idArray = [NSMutableArray array];
    }
    
    return _idArray;
}

- (NSMutableArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
    }
    
    return _nameArray;
}

- (NSMutableArray *)valueArray {
    if (!_valueArray) {
        _valueArray = [NSMutableArray array];
    }
    
    return _valueArray;
}

@end
