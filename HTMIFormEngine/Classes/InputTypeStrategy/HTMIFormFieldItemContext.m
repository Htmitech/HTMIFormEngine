//
//  HTMIFormFieldItemStrategy.m
//  MXClient
//
//  Created by wlq on 2017/8/31.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormFieldItemContext.h"

#import "HTMITabFormModel.h"

#import "HTMIFormTimeView.h"
#import "HTMIFormChoiceBoxView.h"
#import "HTMIFormSelectPeopleView.h"
#import "HTMIFormSelectNodeView.h"
#import "HTMIFormSelectPoepleNodeView.h"
#import "HTMIFormOpinionAutographView.h"
#import "HTMIFormReaderView.h"
#import "HTMIFormTextFieldView.h"
#import "HTMIFormTextView.h"
#import "HTMIFormPullDownView.h"
#import "HTMIFormImageView.h"
#import "HTMIFormGpsView.h"
//文本
#import "HTMIWorkFlowInputType101Strategy.h"
#import "HTMIWorkFlowInputType102Strategy.h"

//整数、小数、整数（带千分符）、小数（带千分符）
#import "HTMIWorkFlowInputType200Strategy.h"
#import "HTMIWorkFlowInputType201Strategy.h"
#import "HTMIWorkFlowInputType202Strategy.h"
#import "HTMIWorkFlowInputType203Strategy.h"

//日期、日期时间、年、月、周、上午下午
#import "HTMIWorkFlowInputType300Strategy.h"
#import "HTMIWorkFlowInputType301Strategy.h"
#import "HTMIWorkFlowInputType302Strategy.h"
#import "HTMIWorkFlowInputType303Strategy.h"
#import "HTMIWorkFlowInputType304Strategy.h"
#import "HTMIWorkFlowInputType305Strategy.h"

//下拉选择取ID、Name、Value，支持输入结果取Name
#import "HTMIWorkFlowInputType401Strategy.h"
#import "HTMIWorkFlowInputType402Strategy.h"
#import "HTMIWorkFlowInputType403Strategy.h"
#import "HTMIWorkFlowInputType412Strategy.h"

//单选（ID、Name、Value），多选（ID、Name、Value）
#import "HTMIWorkFlowInputType501Strategy.h"
#import "HTMIWorkFlowInputType502Strategy.h"
#import "HTMIWorkFlowInputType503Strategy.h"
#import "HTMIWorkFlowInputType511Strategy.h"
#import "HTMIWorkFlowInputType512Strategy.h"
#import "HTMIWorkFlowInputType513Strategy.h"

#import "HTMIWorkFlowInputType521Strategy.h"

//意见、签名、意见或签名
#import "HTMIWorkFlowInputType2001Strategy.h"
#import "HTMIWorkFlowInputType2002Strategy.h"
#import "HTMIWorkFlowInputType2003Strategy.h"
#import "HTMIWorkFlowInputType2004Strategy.h"

//人员选择
#import "HTMIWorkFlowInputType601Strategy.h"
#import "HTMIWorkFlowInputType602Strategy.h"
#import "HTMIWorkFlowInputType603Strategy.h"
#import "HTMIWorkFlowInputType611Strategy.h"
#import "HTMIWorkFlowInputType612Strategy.h"
#import "HTMIWorkFlowInputType613Strategy.h"

//部门选择
#import "HTMIWorkFlowInputType901Strategy.h"
#import "HTMIWorkFlowInputType902Strategy.h"
#import "HTMIWorkFlowInputType911Strategy.h"
#import "HTMIWorkFlowInputType912Strategy.h"

//部门或人员单选
#import "HTMIWorkFlowInputType1001Strategy.h"

//读者作者相关
#import "HTMIWorkFlowInputType3001Strategy.h"
#import "HTMIWorkFlowInputType3002Strategy.h"
#import "HTMIWorkFlowInputType3011Strategy.h"
#import "HTMIWorkFlowInputType3012Strategy.h"

//选择图片
#import "HTMIWorkFlowInputType6001Strategy.h"
#import "HTMIWorkFlowInputType6002Strategy.h"
#import "HTMIWorkFlowInputType6101Strategy.h"
#import "HTMIWorkFlowInputType6102Strategy.h"

//选择音频
#import "HTMIWorkFlowInputType4001Strategy.h"
#import "HTMIWorkFlowInputType4002Strategy.h"
#import "HTMIWorkFlowInputType4101Strategy.h"
#import "HTMIWorkFlowInputType4102Strategy.h"

//选择视频
#import "HTMIWorkFlowInputType5001Strategy.h"
#import "HTMIWorkFlowInputType5002Strategy.h"
#import "HTMIWorkFlowInputType5101Strategy.h"
#import "HTMIWorkFlowInputType5102Strategy.h"

//gps
#import "HTMIWorkFlowInputType7001Strategy.h"

//滑动选择
#import "HTMIWorkFlowInputType8001Strategy.h"

//默认的
#import "HTMIWorkFlowInputTypeDefaultStrategy.h"

#import "UtilsMacros.h"


typedef NS_ENUM(NSUInteger, HTMIFormFieldItemGetType) {
    HTMIFormFieldItemGetViewType = 1,
    HTMIFormFieldItemGetTypeHeight = 2,
};

@interface HTMIFormFieldItemContext()

/**
 字段view
 */
@property (nonatomic, strong) HTMIFormBaseView * formBaseView;

/**
 字段模型
 */
@property (nonatomic, strong) HTMIFieldItemModel * formFieldItemModel;

/**
 高度
 */
@property (nonatomic, assign) CGFloat formFieldItemViewHeight;

@end

@implementation HTMIFormFieldItemContext

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert(NO,@"只能使用指定构造函数进行初始化initWithFormFieldItemModel:");
    }
    return self;
}

- (instancetype)initWithFormFieldItemModel:(HTMIFieldItemModel *)formFieldItemModel
{
    self = [super init];
    if (self) {
        
        self.formFieldItemModel = formFieldItemModel;
    }
    return self;
}

/**
 根据输入类型获取字段View
 
 @param inputType 字段输入类型
 @return 字段View
 */
- (HTMIFormBaseView *)getFieldItemView:(NSString *)inputType {
    
    [self p_setupFieldItemViewInfo:inputType
                           getType:HTMIFormFieldItemGetViewType
                          fontSize:0
                    tableItemModel:nil];
    
    return self.formBaseView;
}


/**
 获取字段view高度
 
 @param inputType 输入类型
 @param nameString 名称
 @param valueString 值
 @param itemWidth item的宽度
 @param fontSize 字体大小
 @param tableItemModel item模型
 @return 字段view高度
 */
- (CGFloat)getFieldItemViewHeight:(NSString *)inputType
                         fontSize:(CGFloat)fontSize
                   tableItemModel:(HTMITabFormModel *)tableItemModel {
    
    [self p_setupFieldItemViewInfo:inputType
                           getType:HTMIFormFieldItemGetTypeHeight
                          fontSize:fontSize
                    tableItemModel:tableItemModel];
    
    return self.formFieldItemViewHeight;
}

- (void)p_setupFieldItemViewInfo:(NSString *)inputType
                         getType:(HTMIFormFieldItemGetType)getType
                        fontSize:(CGFloat)fontSize
                  tableItemModel:(HTMITabFormModel *)tableItemModel {
    
    CGFloat itemWidth = kScreenWidth * (self.formFieldItemModel.percent / 100.f);
    
    //拼接好的字段名称
    NSString *nameString = [NSString stringWithFormat:@"%@%@%@%@", self.formFieldItemModel.beforeNameString, self.formFieldItemModel.nameString, self.formFieldItemModel.endNameString, self.formFieldItemModel.splitString];
    
    //拼接好的值
    NSString *valueString = [NSString stringWithFormat:@"%@%@%@", self.formFieldItemModel.beforeValueString, self.formFieldItemModel.valueString, self.formFieldItemModel.endValueString];
    
    HTMIFormBaseView * formBaseView = nil;
    
    [self.formFieldItemModel htmi_setupFormLabelFont:fontSize];
    
    CGFloat height = 0;
    
    NSInteger inputTypeInteger = [inputType integerValue];
    
    switch (inputTypeInteger) {
        case 101://文本
        {
            HTMIWorkFlowInputType101Strategy *workFlowInputType101Strategy = [[HTMIWorkFlowInputType101Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType101Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType101Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 102://大文本
        {
            HTMIWorkFlowInputType102Strategy *workFlowInputType102Strategy = [[HTMIWorkFlowInputType102Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType102Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType102Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            break;
            
        case 200:        //整数、小数、整数（带千分符）、小数（带千分符）
        {
            HTMIWorkFlowInputType200Strategy *workFlowInputType200Strategy = [[HTMIWorkFlowInputType200Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType200Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType200Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 201:
        {
            HTMIWorkFlowInputType201Strategy *workFlowInputType201Strategy = [[HTMIWorkFlowInputType201Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType201Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType201Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 202:
        {
            HTMIWorkFlowInputType202Strategy *workFlowInputType202Strategy = [[HTMIWorkFlowInputType202Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType202Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType202Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 203:
        {
            HTMIWorkFlowInputType203Strategy *workFlowInputType203Strategy = [[HTMIWorkFlowInputType203Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType203Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType203Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 300://日期、日期时间、年、月、周、上午下午
        {
            HTMIWorkFlowInputType300Strategy *workFlowInputType300Strategy = [[HTMIWorkFlowInputType300Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType300Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType300Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 301:
        {
            HTMIWorkFlowInputType301Strategy *workFlowInputType301Strategy = [[HTMIWorkFlowInputType301Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType301Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType301Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 302:
        {
            HTMIWorkFlowInputType302Strategy *workFlowInputType302Strategy = [[HTMIWorkFlowInputType302Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType302Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType302Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 303:
        {
            HTMIWorkFlowInputType303Strategy *workFlowInputType303Strategy = [[HTMIWorkFlowInputType303Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType303Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType303Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 304:
        {
            HTMIWorkFlowInputType304Strategy *workFlowInputType304Strategy = [[HTMIWorkFlowInputType304Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType304Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType304Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 305:
        {
            HTMIWorkFlowInputType305Strategy *workFlowInputType305Strategy = [[HTMIWorkFlowInputType305Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType305Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType305Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            break;
            
        case 401://下拉选择取ID、Name、Value，支持输入结果取Name
        {
            HTMIWorkFlowInputType401Strategy *workFlowInputType401Strategy = [[HTMIWorkFlowInputType401Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType401Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType401Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 402:
        {
            HTMIWorkFlowInputType402Strategy *workFlowInputType402Strategy = [[HTMIWorkFlowInputType402Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType402Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType402Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 403:
        {
            HTMIWorkFlowInputType403Strategy *workFlowInputType403Strategy = [[HTMIWorkFlowInputType403Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType403Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType403Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 412:
        {
            HTMIWorkFlowInputType412Strategy *workFlowInputType412Strategy = [[HTMIWorkFlowInputType412Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType412Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType412Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            break;
        case 501://单选（ID、Name、Value），多选（ID、Name、Value）
        {
            HTMIWorkFlowInputType501Strategy *workFlowInputType501Strategy = [[HTMIWorkFlowInputType501Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType501Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType501Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 502:
        {
            HTMIWorkFlowInputType502Strategy *workFlowInputType502Strategy = [[HTMIWorkFlowInputType502Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType502Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType502Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 503:
        {
            HTMIWorkFlowInputType503Strategy *workFlowInputType503Strategy = [[HTMIWorkFlowInputType503Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType503Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType503Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 511:
        {
            HTMIWorkFlowInputType511Strategy *workFlowInputType511Strategy = [[HTMIWorkFlowInputType511Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType511Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType511Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 512:
        {
            HTMIWorkFlowInputType512Strategy *workFlowInputType512Strategy = [[HTMIWorkFlowInputType512Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType512Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType512Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 513:
        {
            HTMIWorkFlowInputType513Strategy *workFlowInputType513Strategy = [[HTMIWorkFlowInputType513Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType513Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType513Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
           
            case 521:
            case 522:
            case 523:
            case 531:
            case 532:
            case 533:
        {
            HTMIWorkFlowInputType521Strategy *workFlowInputType521Strategy = [[HTMIWorkFlowInputType521Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType521Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType521Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 601: //选人单选（ID、Name（中文名）、LoginName（登录名）），选人多选（ID、Name、LoginName）
        {
            HTMIWorkFlowInputType601Strategy *workFlowInputType601Strategy = [[HTMIWorkFlowInputType601Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType601Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType601Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 602:
        {
            HTMIWorkFlowInputType602Strategy *workFlowInputType602Strategy = [[HTMIWorkFlowInputType602Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType602Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType602Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 603:
        {
            HTMIWorkFlowInputType603Strategy *workFlowInputType603Strategy = [[HTMIWorkFlowInputType603Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType603Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType603Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 611:
        {
            HTMIWorkFlowInputType611Strategy *workFlowInputType611Strategy = [[HTMIWorkFlowInputType611Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType611Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType611Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 612:
        {
            HTMIWorkFlowInputType612Strategy *workFlowInputType612Strategy = [[HTMIWorkFlowInputType612Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType612Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType612Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 613:
        {
            HTMIWorkFlowInputType613Strategy *workFlowInputType613Strategy = [[HTMIWorkFlowInputType613Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType613Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType613Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 901: //选部门单选（Name、ID），选部门多选（Name、ID）
        {
            HTMIWorkFlowInputType901Strategy *workFlowInputType901Strategy = [[HTMIWorkFlowInputType901Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType901Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType901Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 902:
        {
            HTMIWorkFlowInputType902Strategy *workFlowInputType902Strategy = [[HTMIWorkFlowInputType902Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType902Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType902Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 911:
        {
            HTMIWorkFlowInputType911Strategy *workFlowInputType911Strategy = [[HTMIWorkFlowInputType911Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType911Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType911Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 912:
        {
            HTMIWorkFlowInputType912Strategy *workFlowInputType912Strategy = [[HTMIWorkFlowInputType912Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType912Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType912Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            break;
            
        case 1001://不限人员、部门。选择的结果有可能是部门，也有可能是人员。只限单选
        {
            HTMIWorkFlowInputType1001Strategy *workFlowInputType1001Strategy = [[HTMIWorkFlowInputType1001Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType1001Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType1001Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            break;
        case 2001: //意见、签名、意见或签名
        {
            HTMIWorkFlowInputType2001Strategy *workFlowInputType2001Strategy = [[HTMIWorkFlowInputType2001Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType2001Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType2001Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 2002:
        {
            HTMIWorkFlowInputType2002Strategy *workFlowInputType2002Strategy = [[HTMIWorkFlowInputType2002Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType2002Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType2002Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 2003:
        {
            HTMIWorkFlowInputType2003Strategy *workFlowInputType2003Strategy = [[HTMIWorkFlowInputType2003Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType2003Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType2003Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 2004:
        {
            
            HTMIWorkFlowInputType2004Strategy *workFlowInputType2004Strategy = [[HTMIWorkFlowInputType2004Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType2004Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType2004Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 3001: //读者（单选、多选）  作者（单选、多选）
        {
            HTMIWorkFlowInputType3001Strategy *workFlowInputType3001Strategy = [[HTMIWorkFlowInputType3001Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType3001Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType3001Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            break;
        case 3002:
        {
            HTMIWorkFlowInputType3002Strategy *workFlowInputType3001Strategy = [[HTMIWorkFlowInputType3002Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType3001Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType3001Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            break;
        case 3011:
        {
            HTMIWorkFlowInputType3011Strategy *workFlowInputType3011Strategy = [[HTMIWorkFlowInputType3011Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType3011Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType3011Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 3012:
        {
            HTMIWorkFlowInputType3012Strategy *workFlowInputType3012Strategy = [[HTMIWorkFlowInputType3012Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType3012Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType3012Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            break;
        case 6001: //图片  6001（仅拍照）、6002 单选        6101（仅拍照）、6102  多选
        {
            HTMIWorkFlowInputType6001Strategy *workFlowInputType6001Strategy = [[HTMIWorkFlowInputType6001Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType6001Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType6001Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            break;
        case 6002:
        {
            HTMIWorkFlowInputType6002Strategy *workFlowInputType6002Strategy = [[HTMIWorkFlowInputType6002Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType6002Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType6002Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            break;
        case 6101:
        {
            HTMIWorkFlowInputType6101Strategy *workFlowInputType6101Strategy = [[HTMIWorkFlowInputType6101Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType6101Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType6101Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            break;
        case 6102:
        {
            HTMIWorkFlowInputType6102Strategy *workFlowInputType6102Strategy = [[HTMIWorkFlowInputType6102Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType6102Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType6102Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 4001: //音频  4001、4002单选      4101、4102多选
        {
            HTMIWorkFlowInputType4001Strategy *workFlowInputType4001Strategy = [[HTMIWorkFlowInputType4001Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType4001Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType4001Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 4002:
        {
            HTMIWorkFlowInputType4002Strategy *workFlowInputType4002Strategy = [[HTMIWorkFlowInputType4002Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType4002Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType4002Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 4101:
        {
            HTMIWorkFlowInputType4101Strategy *workFlowInputType4101Strategy = [[HTMIWorkFlowInputType4101Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType4101Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType4101Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 4102:
        {
            HTMIWorkFlowInputType4102Strategy *workFlowInputType4102Strategy = [[HTMIWorkFlowInputType4102Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType4102Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType4102Strategy getFieldItemViewHeight];
                
            } else {
                
            }
            
        }
            
            break;
            
        case 5001: //视频  5001、5002单选      5101、5102多选
        {
            HTMIWorkFlowInputType5001Strategy *workFlowInputType5001Strategy = [[HTMIWorkFlowInputType5001Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType5001Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType5001Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 5002:
        {
            HTMIWorkFlowInputType5002Strategy *workFlowInputType5002Strategy = [[HTMIWorkFlowInputType5002Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType5002Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType5002Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 5101:
        {
            HTMIWorkFlowInputType5101Strategy *workFlowInputType5101Strategy = [[HTMIWorkFlowInputType5101Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType5101Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType5101Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 5102:
        {
            HTMIWorkFlowInputType5102Strategy *workFlowInputType5102Strategy = [[HTMIWorkFlowInputType5102Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType5102Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType5102Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
            
        case 7001: //GPS 定位
        {
            HTMIWorkFlowInputType7001Strategy *workFlowInputType7001Strategy = [[HTMIWorkFlowInputType7001Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType7001Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType7001Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
        case 8001: //滑动选择单值
        case 8002: //滑动选择区间
        {
            HTMIWorkFlowInputType8001Strategy *workFlowInputType8001Strategy = [[HTMIWorkFlowInputType8001Strategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputType8001Strategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputType8001Strategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
            
        default://其它，仅显示
        {
            HTMIWorkFlowInputTypeDefaultStrategy *workFlowInputTypeDefaultStrategy = [[HTMIWorkFlowInputTypeDefaultStrategy alloc] initWithFieldItemModel:self.formFieldItemModel tabFormModel:tableItemModel];
            
            if (getType == HTMIFormFieldItemGetViewType) {
                
                formBaseView = [workFlowInputTypeDefaultStrategy getFieldItemView];
                
            }else if (getType == HTMIFormFieldItemGetTypeHeight) {
                
                height = [workFlowInputTypeDefaultStrategy getFieldItemViewHeight];
                
            } else {
                
            }
        }
            break;
    }
    
    self.formBaseView = formBaseView;
    self.formFieldItemViewHeight = height;
    
}

@end
