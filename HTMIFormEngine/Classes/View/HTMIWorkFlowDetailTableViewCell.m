//
//  HTMIWorkFlowDetailTableViewCell.m
//  MXClient
//
//  Created by wlq on 2018/1/29.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "HTMIWorkFlowDetailTableViewCell.h"

#import "HTMIRegionCellModel.h"
#import "HTMITabFormModel.h"
#import "HTMIFormFieldItemContext.h"
#import "HTMIUserdefaultHelper.h"
#import "HTMIWorkFlowExtModel.h"
#import "HTMIWorkFlowExtAudioView.h"
#import "HTMISettingManager.h"
#import "HTMISupportCopyLabel.h"
#import "NSString+HTMISize.h"
#import "HTMIFormComponentHeader.h"
#import "UIColor+Hex.h"
#import "HTMIPickerView.h"
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
#import "HTMIFormFieldItemContext.h"
#import "UITableViewCell+GetCell.h"
//#import "HTMIMatterFormModel.h"
#import "ACSelectMediaView_form.h"
#import "HTMIFormEngineView.h"

#define formLineColor [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0]

@interface HTMIWorkFlowDetailTableViewCell()<HTMIFormBaseViewDelegate>

/**
 水印透明度
 */
@property (nonatomic, readwrite ,assign) CGFloat waterMarkAlpha;

/**
 数据源
 */
@property (nonatomic, readwrite ,weak) HTMITabFormModel *tabFormModel;

/**
 行数据源
 */
@property (nonatomic, readwrite ,weak) HTMIRegionCellModel *infoRegion;

/**
 表单的整体字体大小
 */
@property (nonatomic, readwrite ,assign) NSInteger formLabelFont;

/**
 控制器
 */
@property (nonatomic, readwrite ,weak) UIViewController *controller;

@property (nonatomic, strong) HTMIFormEngineView *superView;

@end

@implementation HTMIWorkFlowDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier superView:(UIView *)superView {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _superView = (HTMIFormEngineView *)superView;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupDataSourceWithRegionCellModel:(HTMIRegionCellModel *)infoRegion
                              tabFormModel:(HTMITabFormModel *)tabFormModel
                            waterMarkAlpha:(CGFloat)waterMarkAlpha
                             formLabelFont:(NSInteger)formLabelFont
           oaMatterFormTableViewController:(UIViewController *)oaMatterFormTableViewController {
   
    self.infoRegion = infoRegion;
    self.tabFormModel = tabFormModel;
    self.waterMarkAlpha = waterMarkAlpha;
    self.formLabelFont = formLabelFont;
    self.controller = oaMatterFormTableViewController;

}

#pragma mark --------------------------------cell显示内容--------------------------------------
- (void)configureCellWithRegionCellModel:(HTMIRegionCellModel *)infoRegion atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    //互联网表单统一为白色
    if (self.tabFormModel.tabStyle == 0) {
        
        self.backgroundColor = infoRegion.backColorForCell;
    } else {
        
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:self.waterMarkAlpha];
    }
    
    CGFloat currentX = 0;
    
    CGFloat cellHeight = [infoRegion tableViewCellHeightByTabFormModel:self.tabFormModel formLabelFont:self.formLabelFont];
    
    /**
     *  滑动子表部分
     */
    UIScrollView *scrollView = [self p_slideableSubFormWithRegionCellModel:infoRegion
                                                                cellHeight:cellHeight
                                                                      cell:self];
    
    for (NSInteger i = 0; i<[infoRegion.fieldItemArray count]; i++) {
        HTMIFieldItemModel *fieldItem = infoRegion.fieldItemArray[i];
        
        UIColor *backColor = [UIColor colorWithHex:[NSString stringWithFormat:@"%x",(int)fieldItem.backColor]
                                             alpha:self.waterMarkAlpha
                                           isWhite:self.tabFormModel.tabStyle];
        
        CGFloat itemWidth = kScreenWidth * (fieldItem.percent / 100.f);
        
        NSString *nameString = [NSString stringWithFormat:@"%@%@", fieldItem.nameString, fieldItem.splitString];
        NSString *valueString = [NSString stringWithFormat:@"%@%@%@", fieldItem.beforeValueString, fieldItem.valueString, fieldItem.endValueString];
        
        UIView *totalView = [[UIView alloc] init];
        totalView.tag = i;
        
        if (fieldItem.backColor != 0 && self.tabFormModel.tabStyle == 0) {
            totalView.backgroundColor = backColor;
        }
        
        /**
         *  滑动子表
         */
        if (infoRegion.scrollFlag == 1 && infoRegion.parentRegionIdString.length > 0) {
            //滑动
            totalView.frame = CGRectMake(currentX, 0, itemWidth , cellHeight);
            
            if (i >= infoRegion.scrollFixColCount) {
                //滑动部分
                [scrollView addSubview:totalView];
                
                // 加上一条纵向的分割线   BOOL vlineVisible
                if (i > 0 && infoRegion.vlineVisible && currentX > 0) {
                    //添加竖线
                    UIImageView *splitView = [[UIImageView alloc] init];
                    splitView.frame = CGRectMake(currentX, 0, formLineWidth, cellHeight);
                    splitView.backgroundColor = formLineColor;
                    [scrollView addSubview:splitView];
                }
                
                currentX += itemWidth;  // 左移 x 值，供后续 Label 使用
                
            } else {
                //固定部分
                [self.contentView addSubview:totalView];
                
                // 加上一条纵向的分割线   BOOL vlineVisible
                if (i > 0 && infoRegion.vlineVisible) {
                    //添加竖线
                    UIImageView *splitView = [[UIImageView alloc] init];
                    splitView.frame = CGRectMake(currentX, 0, 2, cellHeight);
                    splitView.backgroundColor = formLineColor;
                    [self.contentView addSubview:splitView];
                }
                
                //固定行后边加一条线
                if (i == infoRegion.scrollFixColCount-1) {
                    UIImageView *splitView = [[UIImageView alloc] init];
                    splitView.frame = CGRectMake(currentX+itemWidth-formLineWidth, 0, formLineWidth, cellHeight);
                    splitView.backgroundColor = formLineColor;
                    [self.contentView addSubview:splitView];
                }
                
                currentX += itemWidth;  // 左移 x 值，供后续 Label 使用
            }
            
            if (i == infoRegion.scrollFixColCount-1) {
                currentX = 0;
            }
            
            //显示内容
            [self itemDetailsTypeFieldItem:fieldItem
                                      name:nameString
                                     value:valueString
                                     width:itemWidth
                                 totalView:totalView
                                cellHeight:cellHeight
                                 tableView:tableView
                                 indexPath:indexPath];
            
        } else {
            //不滑动
            totalView.frame = CGRectMake(currentX, 0, itemWidth, cellHeight);
            [self.contentView addSubview:totalView];
            
            //显示内容
            [self itemDetailsTypeFieldItem:fieldItem name:nameString value:valueString width:itemWidth totalView:totalView cellHeight:cellHeight tableView:tableView indexPath:indexPath];
            
            // 加上一条纵向的分割线   BOOL vlineVisible
            if (i > 0 && infoRegion.vlineVisible) {
                //添加竖线
                UIImageView *splitView = [[UIImageView alloc] init];
                splitView.frame = CGRectMake(currentX, 0, formLineWidth, cellHeight);
                splitView.backgroundColor = formLineColor;
                [self.contentView addSubview:splitView];
            }
            
            currentX += itemWidth;  // 左移 x 值，供后续 Label 使用
        }
    }
    
    //画线
    [self p_drawCellLineInView:self.contentView
                     tableView:tableView
                     indexPath:indexPath
                      tabStyle:self.tabFormModel.tabStyle
               regionCellModel:infoRegion];
    
    
    if (infoRegion.isSplitRegion && infoRegion.splitAction == 0) {
        //分割部分
        if (self.tabFormModel.tabStyle == 0) {
            self.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:self.waterMarkAlpha];
            
        }
        
    } else if (infoRegion.isSplitRegion && infoRegion.splitAction == 1) {
        UIImageView *downImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-60, cellHeight/2-30, 60, 60)];
        
        if (infoRegion.isOpen) {
            downImage.image = [UIImage imageNamed:@"btn_angle_down_circle"];
        } else {
            downImage.image = [UIImage imageNamed:@"btn_angle_up_circle"];
        }
        
        [self.contentView addSubview:downImage];
    }
}

#pragma mark -------------------------------------------计算cell行高

//滑动子表
- (UIScrollView *)p_slideableSubFormWithRegionCellModel:(HTMIRegionCellModel *)infoRegion cellHeight:(CGFloat)cellHeight cell:(UITableViewCell *)cell {
    
    CGFloat staticFlagWidth = 0;//固定前几行的宽度
    CGFloat contentWidth = 0;//滑动宽度
    
    NSMutableArray *scrollViewArray = [NSMutableArray array];
    BOOL isHave = NO;
    NSInteger replaceIndex = 0;
    
    UIScrollView *scrollView = nil;
    if (infoRegion.scrollFlag == 1 && infoRegion.parentRegionIdString.length > 0) {
        
        for (int i = 0; i < infoRegion.fieldItemArray.count; i++) {
            
            HTMIFieldItemModel *fieldItem = infoRegion.fieldItemArray[i];
            
            CGFloat itemWidth = kScreenWidth * (fieldItem.percent / 100.f);
            
            if (i < infoRegion.scrollFixColCount) {
                staticFlagWidth += itemWidth;
            }
            else {
                contentWidth += itemWidth;
            }
        }
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(staticFlagWidth, 0, kScreenWidth-staticFlagWidth, cellHeight)];
        scrollView.delegate = self.superView;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(contentWidth, cellHeight);
        [scrollView setContentOffset:CGPointMake([[self.superView.contentOffSetDic objectForKey:infoRegion.parentRegionIdString] floatValue], 0)];
        [cell.contentView addSubview:scrollView];
        
        [scrollViewArray addObject:infoRegion.regionIdString];
        [scrollViewArray addObject:scrollView];
        [scrollViewArray addObject:infoRegion.parentRegionIdString];
        
        if (self.superView.scrollViewArray.count > 0) {
            for (int j = 0; j < self.superView.scrollViewArray.count; j++) {
                NSArray *array = self.superView.scrollViewArray[j];
                if ([infoRegion.regionIdString isEqualToString:array[0]]) {
                    replaceIndex = j;
                    isHave = YES;
                }
            }
        }

        if (isHave) {
            [self.superView.scrollViewArray replaceObjectAtIndex:replaceIndex withObject:scrollViewArray];
        }
        else {
            [self.superView.scrollViewArray addObject:scrollViewArray];
        }
    }
    
    return scrollView;
    
}

#pragma mark  ------ 画线

//画线
- (void)p_drawCellLineInView:(UIView *)view tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath tabStyle:(NSInteger)tabStyle regionCellModel:(HTMIRegionCellModel *)regionCellModel {
    
    if (tabStyle == 0) {
        [self drawLineInView:view tableView:tableView indexpath:indexPath regionCellModel:regionCellModel];
    } else {
        [self drawNetWorkFormLine:view tableView:tableView indexpath:indexPath regionCellModel:regionCellModel];
    }
}


- (void)drawLineInView:(UIView *)view
             tableView:(UITableView *)tableView
             indexpath:(NSIndexPath *)indexPath
       regionCellModel:(HTMIRegionCellModel *)regionCellModel {
    
    CGFloat height = [regionCellModel tableViewCellHeightByTabFormModel:self.tabFormModel formLabelFont:self.formLabelFont];
    
    UIImageView *leftLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, formLineWidth, height)];
    leftLine.backgroundColor = formLineColor;
    [view addSubview:leftLine];
    
    UIImageView *rightLine = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-formLineWidth, 0, formLineWidth, height)];
    rightLine.backgroundColor = formLineColor;
    [view addSubview:rightLine];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, formLineWidth)];
    lineImage.backgroundColor = formLineColor;
    [view addSubview:lineImage];
    
    //最下边的线
    if (indexPath.row == self.superView.infoRegionArray.count-1) {
        UIImageView *lastLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, height-formLineWidth, kScreenWidth, formLineWidth)];
        lastLine.backgroundColor = formLineColor;
        [view addSubview:lastLine];
    }
}

//互联网画线
- (void)drawNetWorkFormLine:(UIView *)view
                  tableView:(UITableView *)tableView
                  indexpath:(NSIndexPath *)indexPath
            regionCellModel:(HTMIRegionCellModel *)regionCellModel {
    
    CGFloat cellHeight = [regionCellModel tableViewCellHeightByTabFormModel:self.tabFormModel formLabelFont:self.formLabelFont];
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, cellHeight-1, kScreenWidth, 1)];
    lineImage.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [view addSubview:lineImage];
}


#pragma mark ------------------------------------------- item内容
- (void)itemDetailsTypeFieldItem:(HTMIFieldItemModel *)fieldItem name:(NSString *)nameString value:(NSString *)valueString width:(CGFloat)itemWidth totalView:(UIView *)view cellHeight:(CGFloat)cellHeight tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    HTMIFormFieldItemContext *formFieldItemStrategy = [[HTMIFormFieldItemContext alloc] initWithFormFieldItemModel:fieldItem];
    
    HTMIFormBaseView *formBaseView = [formFieldItemStrategy getFieldItemView:fieldItem.inputString];
    
    if (formBaseView == nil) {
        
        if ([fieldItem.inputString isEqualToString:@"4001"] ||
            [fieldItem.inputString isEqualToString:@"4002"] ||
            [fieldItem.inputString isEqualToString:@"4101"] ||
            [fieldItem.inputString isEqualToString:@"4102"]) {//audio_type
            //音频  4001、4002单选      4101、4102多选
            [self extFieldAudio:fieldItem superView:view itemWidth:itemWidth cellHeight:cellHeight];
            
        } else if ([fieldItem.inputString isEqualToString:@"5001"] ||
                   [fieldItem.inputString isEqualToString:@"5002"] ||
                   [fieldItem.inputString isEqualToString:@"5101"] ||
                   [fieldItem.inputString isEqualToString:@"5102"]) {
            //视频   5001（仅拍照）、5002 单选        5101（仅拍照）、5102  多选
            [self extFieldVideo:fieldItem superView:view itemWidth:itemWidth cellHeight:cellHeight];
            
        } else {
            //常规
            [self normalInputTypeFieldItem:fieldItem
                                      name:nameString
                                     value:valueString
                                     width:itemWidth
                                 superView:view
                                cellheight:cellHeight];
        }
    }
    
    if (formBaseView != nil) {
        
        formBaseView.delegate = self.controller;
        [formBaseView setFieldItemModel:fieldItem
                          formLabelFont:self.formLabelFont
                    matterFormTableView:tableView
                        infoRegionArray:self.superView.infoRegionArray
                             nameString:nameString
                            valueString:valueString
                              itemWidth:itemWidth
                             cellHeight:cellHeight
                             controller:self.controller
                              indexPath:indexPath
                         tableItemModel:self.tabFormModel];
        
        [formBaseView inputTypeFieldItem:fieldItem name:nameString value:valueString width:itemWidth totalView:view cellHeight:cellHeight];
    }
}

#pragma mark ------ 图片、音频、视频
//视频
- (void)extFieldVideo:(HTMIFieldItemModel *)fieldItem superView:(UIView *)superView itemWidth:(CGFloat)itemWidth cellHeight:(CGFloat)cellHeight {
    
    if (!fieldItem.mediaView) {
        CGFloat height = [ACSelectMediaView_form defaultViewHeightByItemWidth:itemWidth];
        ACSelectMediaView_form *mediaView = [[ACSelectMediaView_form alloc] initWithFrame:CGRectMake(0, 0, itemWidth, height)];
        
        if ((![fieldItem.modeString isEqual:[NSNull null]] && [fieldItem.modeString isEqualToString:@"1"])) {
            
            //可编辑
            mediaView.showDelete = YES;//是否显示删除按钮
            mediaView.showAddButton = YES;
        }
        else{
            mediaView.showDelete = NO;
            mediaView.showAddButton = NO;
        }
        if (fieldItem.filedVideoArray.count > 0) {//请求到的
            NSMutableArray *preShowImageArray = [NSMutableArray array];
            for (HTMIWorkFlowExtModel *extModel in fieldItem.filedVideoArray) {
                [preShowImageArray addObject:extModel.file_url];
            }
            mediaView.preShowMedias = preShowImageArray;
        }
        
        switch ([fieldItem.inputString integerValue]) {
            case 5001://单选仅录像
                mediaView.maxImageSelected = 1;
                mediaView.type = ACMediaTypeVideotape;
                
                break;
            case 5002://单选
                mediaView.maxImageSelected = 1;
                mediaView.type = ACMediaTypeVideoAndTape;
                
                break;
            case 5101://多选仅录像
                mediaView.type = ACMediaTypeVideotape;
                
                break;
            case 5102://多选
                mediaView.type = ACMediaTypeVideoAndTape;
                
                break;
                
            default:
                break;
        }
        
        mediaView.allowMultipleSelection = NO;
        [superView addSubview:mediaView];
        fieldItem.mediaView = mediaView;
        
        __weak typeof(fieldItem) weakItem = fieldItem;
        [mediaView observeViewHeight:^(CGFloat mediaHeight) {

            weakItem.imageHeight = mediaHeight;
//            [self.oaMatterFormTableViewController.matterFormTableView reloadData];
        }];
        
        
        [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel_form *> *list) {
            
            //请求到的是URL，所以 mediaModel.imageUrlString 有值的排除，其它上交
            NSMutableArray *videoSelectArray = [NSMutableArray array];
            for (ACMediaModel_form *mediaModel in list) {
                if (!mediaModel.imageUrlString) {
                    [videoSelectArray addObject:mediaModel];
                }
            }
            
            //只是每个item的视频，总的图片得后续处理
            NSLog(@"上交的 ACMediaModel 视频数组：%@",videoSelectArray);
        }];
    } else {
        [superView addSubview:fieldItem.mediaView];
    }
}

//音频
- (void)extFieldAudio:(HTMIFieldItemModel *)fieldItem superView:(UIView *)superView itemWidth:(CGFloat)itemWidth cellHeight:(CGFloat)cellHeight {
    
    BOOL isHave = [self isFileExist:extFieldAudioPath(@"")];
    
    if (!isHave) {
        //创建音频文件夹
        [[NSFileManager defaultManager] createDirectoryAtPath:extFieldAudioPath(@"") withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSInteger numberInRow = (itemWidth-24)/(extFieldAudioSingleHeight-24);//每行放几个
    //NSInteger count = fieldItem.ext_filed_audios.count+1+fieldItem.ext_filed_audios_add.count;//多少个
    //    NSInteger row = count%numberInRow==0 ? count/numberInRow : count/numberInRow+1;//多少行
    
    NSInteger tag = 0;
    
    if (fieldItem.filedAudioArray.count > 0) {//有已经存在的
        for (HTMIWorkFlowExtModel *extModel in fieldItem.filedAudioArray) {
            
            HTMIWorkFlowExtAudioView *audioView = [[HTMIWorkFlowExtAudioView alloc] init];
            audioView.tag = tag;
            audioView.frame = CGRectMake(12+50*(tag%numberInRow), 12+50*(tag/numberInRow), 50, 50);
            audioView.audioUrlString = extModel.file_url;
            [superView addSubview:audioView];
//            [self.oaMatterFormTableViewController.extAudioArray addObject:audioView];
            
            tag++;
            
            audioView.audioPlayBlock = ^(HTMIWorkFlowExtAudioView *extAudioView) {
                
                //停止其它音频的播放
//                [self stopAnotherAudioPlayerPlay:superView audioView:extAudioView];
                
            };
            
            //删除
            audioView.deleteBlock = ^(HTMIWorkFlowExtAudioView *extAudioView) {
                
                [fieldItem htmi_removeAllFiledAudiosAarrayItem];
//                [self.oaMatterFormTableViewController.extAudioArray removeObject:extAudioView];
//
//                [self.oaMatterFormTableViewController.matterFormTableView reloadData];
            };
        }
    }
    
    if (fieldItem.extFiledAudiosAddMarray.count > 0) {//有已近添加的
        for (HTMIWorkFlowExtModel *audioModel in fieldItem.extFiledAudiosAddMarray) {
            
            audioModel.extAudioView.tag = tag;
            audioModel.extAudioView.frame = CGRectMake(12+50*(tag%numberInRow), 12+50*(tag/numberInRow), 50, 50);
            audioModel.extAudioView.audioPathString = audioModel.file_path_string;
            [superView addSubview:audioModel.extAudioView];
            
            tag++;
            
            audioModel.extAudioView.audioPlayBlock = ^(HTMIWorkFlowExtAudioView *extAudioView) {
                
                //停止其它音频的播放
//                [self stopAnotherAudioPlayerPlay:superView audioView:extAudioView];
                
            };
            
            //删除
            audioModel.extAudioView.deleteBlock = ^(HTMIWorkFlowExtAudioView *extAudioView) {
                
                [fieldItem.extFiledAudiosAddMarray removeObject:extAudioView.audioPathString];
//                [self.oaMatterFormTableViewController.extAudioArray removeObject:extAudioView];
//
//                [self.oaMatterFormTableViewController.matterFormTableView reloadData];
            };
        }
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(12+50*(tag%numberInRow), 12+50*(tag/numberInRow), 50, 50);
    imageView.image = [UIImage imageNamed:@"btn_operation_audio_speak"];
    imageView.userInteractionEnabled = YES;
    imageView.tag = superView.tag;
    [superView addSubview:imageView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(audioTypeLongPress:)];
    longPress.delegate = self;
    longPress.minimumPressDuration = 0.0;
    [imageView addGestureRecognizer:longPress];
    
}

//录音
- (void)audioTypeLongPress:(UILongPressGestureRecognizer *)longPress {
    
//    UITableViewCell *cell = [UITableViewCell getCellBy:longPress.view];
//    self.oaMatterFormTableViewController.currentEidtRegionIndex = [self.oaMatterFormTableViewController.matterFormTableView indexPathForCell:cell].row;
//    self.oaMatterFormTableViewController.currentEidtFieldItemIndex = longPress.view.tag;
    
//    HTMIRegionCellModel *infoRegion = self.oaMatterFormTableViewController.infoRegionArray[self.oaMatterFormTableViewController.currentEidtRegionIndex];
//    HTMIFieldItemModel *fieldItem = infoRegion.fieldItemArray[self.oaMatterFormTableViewController.currentEidtFieldItemIndex];
    
    //防止重名，以regionID+tag命名(单选)   时间（多选）
    //    NSString *pathString = [NSString stringWithFormat:@"%@_%ld.caf",infoRegion.region_id,longPress.view.tag];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyMMddHHmmss";
    NSString *pathString = [NSString stringWithFormat:@"%@.caf",[formatter stringFromDate:[NSDate date]]];
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
//        self.oaMatterFormTableViewController.voiceHUD.tag = longPress.view.tag;
//
//        [self.oaMatterFormTableViewController.voiceHUD startForFilePath:extFieldAudioPath(pathString)];
        
        HTMIWorkFlowExtModel *extAudioModel = [[HTMIWorkFlowExtModel alloc] init];
        extAudioModel.file_path_string = extFieldAudioPath(pathString);
        extAudioModel.extAudioView = [[HTMIWorkFlowExtAudioView alloc] init];
        
//        [fieldItem.extFiledAudiosAddMarray addObject:extAudioModel];
//        [self.oaMatterFormTableViewController.extAudioArray addObject:extAudioModel.extAudioView];
//
//        //录完后添加到总数组，所有tap页的录音文件
//        [self.oaMatterFormTableViewController.operationDelegate extFieldOperationForKey:fieldItem.keyString mode:fieldItem.modeString input:fieldItem.inputString formkey:fieldItem.formkeyString extAudioModel:extAudioModel];
        
    } else if (longPress.state == UIGestureRecognizerStateEnded) {
        
//        [self.oaMatterFormTableViewController.voiceHUD commitRecording];
//
//        [self.oaMatterFormTableViewController.matterFormTableView reloadData];
    }
}


#pragma mark - POVoiceHUD Delegate
//- (void)POVoiceHUD:(POVoiceHUD *)voiceHUD voiceRecorded:(NSString *)recordPath length:(float)recordLength {
//    NSLog(@"Sound recorded with file %@ for %.2f seconds", [recordPath lastPathComponent], recordLength);
//}
//
//- (void)stopAnotherAudioPlayerPlay:(UIView *)superView audioView:(HTMIWorkFlowExtAudioView *)audioView {
//    for (HTMIWorkFlowExtAudioView *view in self.oaMatterFormTableViewController.extAudioArray) {
//        if (![view isEqual:audioView]) {
//
//            HTMIWorkFlowExtAudioView *extAudioView = (HTMIWorkFlowExtAudioView *)view;
//
//            [extAudioView.audioPlayer stop];
//        }
//    }
//}

#pragma mark ------ 普通模式（内容）
- (void)normalInputTypeFieldItem:(HTMIFieldItemModel *)fieldItem name:(NSString *)nameString value:(NSString *)valueString width:(CGFloat)itemWidth superView:(UIView *)superView cellheight:(CGFloat)cellHeight {
    
    CGFloat nameHeight = nameString.length>0 ? [NSString labelSizeWithMaxWidth:itemWidth-stringLeftWidth*2 content:nameString FontOfSize:self.formLabelFont].height+stringTopHeight*2 : 0;
    
    if (fieldItem.nameVisible) {
        if (fieldItem.nameRN) {//显示name且分行显示
            HTMISupportCopyLabel *nameLabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, valueString.length>0 ? nameHeight : cellHeight)
                                                                                   text:nameString
                                                                              alingment:fieldItem.alignString
                                                                              textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
            
            HTMISupportCopyLabel *valueLabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, nameHeight, itemWidth-stringLeftWidth*2, cellHeight-nameHeight)
                                                                                    text:valueString
                                                                               alingment:fieldItem.alignString
                                                                               textColor:fieldItem.valueFontColor fontSize:self.formLabelFont];
            [superView addSubview:nameLabel];
            [superView addSubview:valueLabel];
            
            if (self.tabFormModel.tabStyle == 1) {
                nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
                valueLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
            }
            
        } else {//显示name不分行
            HTMISupportCopyLabel *label = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, cellHeight) text:[NSString stringWithFormat:@"%@%@",nameString,valueString] alingment:fieldItem.alignString textColor:fieldItem.nameFontColor fontSize:self.formLabelFont];
            
            [superView addSubview:label];
            
            if (self.tabFormModel.tabStyle == 1) {
                label.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
            }
        }
    } else {//不显示name
        HTMISupportCopyLabel *valueLabel = [HTMISupportCopyLabel creatLabelWithFrame:CGRectMake(stringLeftWidth, 0, itemWidth-stringLeftWidth*2, cellHeight) text:valueString alingment:fieldItem.alignString textColor:fieldItem.valueFontColor fontSize:self.formLabelFont];
        [superView addSubview:valueLabel];
        
        if (self.tabFormModel.tabStyle == 1) {
            valueLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
        }
    }
}

#pragma mark ------ 是否存在文件夹
- (BOOL)isFileExist:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:fileName];
    return result;
}

@end
