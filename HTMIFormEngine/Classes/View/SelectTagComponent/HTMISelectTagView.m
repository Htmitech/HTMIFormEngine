//
//  HTMISelectTagView.m
//  单选多选
//
//  Created by 赵志国 on 16/6/16.
//  Copyright (c) 2016年 htmitech.com. All rights reserved.
//

#import "HTMISelectTagView.h"

//#import "HTMISelectTableViewCell.h"

#import "HTMIItemDicsModel.h"
#import "HTMIFieldItemModel.h"
#import "NSString+HTMISize.h"
#import "HTMISettingManager.h"

#import "UtilsMacros.h"

#import "HTMIApplicationHubManager.h"

@interface HTMISelectTagView ()

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
 数据源
 */
@property (nonatomic, strong) NSArray *dicsArray;

@end

@implementation HTMISelectTagView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

/**
 优化后的冒泡排序
 
 @param array 要排序的数组
 @return 排完序的数组
 */
+ (NSArray *)p_bubbleSortAdvanced:(NSMutableArray <HTMIItemDicsModel *>*)array {
    
    if (array.count < 1) {
        return array;
    }
    
    for (int i = 0; i < array.count - 1; i++) {
        //bool switch
        BOOL swapped = NO;
        
        for (int j = 0; j < array.count - i - 1; j++) {
            HTMIItemDicsModel * arrayJ = array[j];
            HTMIItemDicsModel * arrayJAdd1 = array[j+1];
            if (arrayJ.nameString.length > arrayJAdd1.nameString.length) {
                
                HTMIItemDicsModel *temp = array[j];
                array[j] = array[j + 1];
                //OC中的数组只能存储对象，所以这里转换成string对象
                array[j + 1] = temp;
                
                swapped = true;
            }
        }
        
        if (swapped == NO){
            break;
        }
    }
    
    return array;
}

+ (CGFloat)formTagViewHeight:(HTMIFieldItemModel *)fieldItemModel {
    
    NSArray *dicsArray = [HTMISelectTagView p_bubbleSortAdvanced:[fieldItemModel.dicsArray mutableCopy]];
    CGFloat parentViewWidth = kScreenWidth;
    //生成按钮
    int x = 10 , y = 20, allX = 10;
    CGFloat standardWidth = (parentViewWidth - 40) / 3;
    for (int i = 0; i < dicsArray.count; i++) {
        HTMIItemDicsModel *itemDicsModel = dicsArray[i];
        
        CGFloat buttonWidth;
        float nameWidth = [NSString labelSizeWithMaxWidth:0 content:itemDicsModel.nameString FontOfSize:12.0].width;
        
        if (nameWidth > standardWidth) {
            
            if (nameWidth > standardWidth * 2) {
                buttonWidth = standardWidth * 3 + 10 *2;//占三列
                
            }else {
                buttonWidth = standardWidth * 2 + 10;//占两列
            }
        }
        else {
            buttonWidth = standardWidth;
        }
        
        allX += (buttonWidth + 10);
        
        if (allX > parentViewWidth) {
            x = 10;
            allX = 10 + buttonWidth + 10;
            y += 40;
        }
        
        x += buttonWidth + 10;
    }
    return y + 20;
}

- (UIButton *)tabsButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    button.layer.borderWidth = 1.5;
    
    [self setNormalStyle:button];
    
    [button addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)setSelectedStyle:(UIButton *)button {
    
    [button setTitleColor:[HTMIApplicationHubManager manager].blueForWhiteControlColor forState:UIControlStateNormal];
    button.layer.borderColor =  [HTMIApplicationHubManager manager].blueForWhiteControlColor.CGColor;
}

- (void)setNormalStyle:(UIButton *)button {
    [button setTitleColor: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    button.layer.borderColor =  [UIColor colorWithRed:182/255.0 green:182/255.0 blue:182/255.0 alpha:1/1.0].CGColor;
}

- (void)tagButtonClick:(UIButton *)btn {
    
    if (self.selectType == SingleSelectTagTypeName) {//单选返回name
        if (self.selectedIndex == btn.tag) {
            return;
        }
        
        if (self.selectedButton) {
            [self setNormalStyle:self.selectedButton];
        }
        
        self.selectedButton = btn;
        self.selectedIndex = btn.tag;
        if (self.singleSelectionBlock) {
            self.singleSelectionBlock(self.nameArray[btn.tag]);
        }
        
        [self setSelectedStyle:btn];
        
    } else if (self.selectType == SingleSelectTagTypeID) {//单选返回id
        if (self.selectedIndex == btn.tag) {
            return;
        }
        if (self.selectedButton) {
            [self setNormalStyle:self.selectedButton];
        }
        
        self.selectedButton = btn;
        self.selectedIndex = btn.tag;
        if (self.singleSelectionBlock) {
            self.singleSelectionBlock(self.idArray[btn.tag]);
        }
        [self setSelectedStyle:btn];
        
    } else if (self.selectType == SingleSelectTagTypeValue) {//单选返回value
        if (self.selectedIndex == btn.tag) {
            return;
        }
        if (self.selectedButton) {
            [self setNormalStyle:self.selectedButton];
        }
        self.selectedButton = btn;
        self.selectedIndex = btn.tag;
        if (self.singleSelectionBlock) {
            self.singleSelectionBlock(self.valueArray[btn.tag]);
        }
        [self setSelectedStyle:btn];
        
    } else if (self.selectType == MultiSelectTagTypeName) {//多选返回name
        
        if ([self.selectedArray containsObject:self.nameArray[btn.tag]]) {
            [self.selectedArray removeObject:self.nameArray[btn.tag]];
            [self setNormalStyle:btn];
        }
        else {
            [self.selectedArray addObject:self.nameArray[btn.tag]];
            [self setSelectedStyle:btn];
        }
        
        if (self.multiSelectionBlock) {
            self.multiSelectionBlock(self.selectedArray);
        }
        
    } else if (self.selectType == MultiSelectTagTypeID) {//多选返回id
        
        if ([self.selectedArray containsObject:self.idArray[btn.tag]]) {
            [self.selectedArray removeObject:self.idArray[btn.tag]];
            [self setNormalStyle:btn];
        }
        else {
            [self.selectedArray addObject:self.idArray[btn.tag]];
            [self setSelectedStyle:btn];
        }
        
        if (self.multiSelectionBlock) {
            self.multiSelectionBlock(self.selectedArray);
        }
        
    } else if (self.selectType == MultiSelectTagTypeValue) {//多选返回value
        
        if ([self.selectedArray containsObject:self.valueArray[btn.tag]]) {
            [self.selectedArray removeObject:self.valueArray[btn.tag]];
            [self setNormalStyle:btn];
        }
        else {
            [self.selectedArray addObject:self.valueArray[btn.tag]];
            [self setSelectedStyle:btn];
        }
        
        if (self.multiSelectionBlock) {
            self.multiSelectionBlock(self.selectedArray);
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame
                    dicsArray:(NSArray *)dicsArray
                   selectType:(SelectTagType)selectType
                  isMustInput:(BOOL)isMustInput
                        value:(NSString *)valueString
         singleSelectionBlock:(HTMISelectTagViewSingleSelectionBlock)singleSelectionBlock
          multiSelectionBlock:(HTMISelectTagViewMultiSelectionBlock)multiSelectionBlock {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.multiSelectionBlock = multiSelectionBlock;
        self.singleSelectionBlock = singleSelectionBlock;
        self.selectedIndex = -1;
        NSArray *sortAdvancedArray = [HTMISelectTagView p_bubbleSortAdvanced:[dicsArray mutableCopy]];
        self.selectType = selectType;
        self.dicsArray = sortAdvancedArray;
        
        for (HTMIItemDicsModel *model in sortAdvancedArray) {
            [self.idArray addObject:model.idString];
            [self.nameArray addObject:model.nameString];
            [self.valueArray addObject:model.valueString];
        }
        
        self.isMustInput = isMustInput;
        self.valueString = valueString;
        CGFloat parentViewWidth = frame.size.width;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, parentViewWidth, frame.size.height)];
        [self addSubview:scrollView];
        
        NSArray *selectedArray = [self.valueString componentsSeparatedByString:@"|"];
        
        //生成按钮
        int x = 10 , y = 0, allX = 10;
        CGFloat standardWidth = (parentViewWidth - 40) / 3;
        for (int i = 0; i < sortAdvancedArray.count; i++) {
            HTMIItemDicsModel *itemDicsModel = sortAdvancedArray[i];
            UIButton *button = [self tabsButton];
            
            if ([selectedArray containsObject:self.nameArray[i]]) {
                
                if (self.selectType == MultiSelectTagTypeID) {
                    [self.selectedArray addObject:self.idArray[i]];
                    [self setSelectedStyle:button];
                } else if (self.selectType == MultiSelectTagTypeName) {
                    [self.selectedArray addObject:self.nameArray[i]];
                    [self setSelectedStyle:button];
                } else if (self.selectType == MultiSelectTagTypeValue) {
                    [self.selectedArray addObject:self.valueArray[i]];
                    [self setSelectedStyle:button];
                }
                if (self.selectType == SingleSelectTagTypeName) {//单选返回name
                    
                    self.selectedIndex = i;
                    if (self.singleSelectionBlock) {
                        
                        self.singleSelectionBlock(self.nameArray[i]);
                    }
                    self.selectedButton = button;
                    [self setSelectedStyle:button];
                    
                } else if (self.selectType == SingleSelectTagTypeID) {//单选返回id
                    
                    self.selectedIndex = i;
                    if (self.singleSelectionBlock) {
                        
                        self.singleSelectionBlock(self.idArray[i]);
                    }
                    self.selectedButton = button;
                    [self setSelectedStyle:button];
                    
                } else if (self.selectType == SingleSelectTagTypeValue) {//单选返回value
                    self.selectedIndex = i;
                    if (self.singleSelectionBlock) {
                        
                        self.singleSelectionBlock(self.valueArray[i]);
                    }
                    self.selectedButton = button;
                    [self setSelectedStyle:button];
                }
            }
            
            CGFloat buttonWidth;
            float nameWidth = [NSString labelSizeWithMaxWidth:0 content:itemDicsModel.nameString FontOfSize:14.0].width;
            
            if (nameWidth > standardWidth) {
                
                if (nameWidth > standardWidth * 2) {
                    buttonWidth = standardWidth * 3 + 10 *2;//占三列
                    
                }else {
                    buttonWidth = standardWidth * 2 + 10;//占两列
                }
            }
            else {
                buttonWidth = standardWidth;
            }
            
            allX += (buttonWidth + 10);
            
            if (allX > parentViewWidth) {
                x = 10;
                allX = 10 + buttonWidth + 10;
                y += 40;
            }
            
            button.frame = CGRectMake(x, y, buttonWidth, 30);
            [button setTitle:itemDicsModel.nameString forState:UIControlStateNormal];
            button.tag = i;
            [scrollView addSubview:button];
            
            x += buttonWidth + 10;
            
        }
        
        if (self.selectedArray.count > 0) {
            if (self.multiSelectionBlock) {
                self.multiSelectionBlock(self.selectedArray);
            }
        }
        
        scrollView.contentSize = CGSizeMake(frame.size.width, y + 20);
    }
    
    return self;
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
