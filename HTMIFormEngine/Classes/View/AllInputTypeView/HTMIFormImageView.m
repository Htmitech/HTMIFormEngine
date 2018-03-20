//
//  HTMIFormImageView.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/25.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMIFormImageView.h"

#import "ACSelectMediaView_form.h"

#import "HTMIWorkFlowExtModel.h"

#import "HTMITabFormModel.h"

@implementation HTMIFormImageView

//图片
- (void)inputTypeFieldItem:(HTMIFieldItemModel *)fieldItem name:(NSString *)nameString value:(NSString *)valueString width:(CGFloat)itemWidth totalView:(UIView *)view cellHeight:(CGFloat)cellHeight {
    
    [view addSubview:self];
    self.frame = view.bounds;
    
    if (!fieldItem.mediaView) {
        CGFloat height = [ACSelectMediaView_form defaultViewHeightByItemWidth:itemWidth];
        ACSelectMediaView_form *mediaView = [[ACSelectMediaView_form alloc] initWithFrame:CGRectMake(0, 10, itemWidth, height)];
        
        if ((![fieldItem.modeString isEqual:[NSNull null]] && [fieldItem.modeString isEqualToString:@"1"])) {
            
            //可编辑
            mediaView.showDelete = YES;//是否显示删除按钮
            mediaView.showAddButton = YES;
        }
        else{
            mediaView.showDelete = NO;
            mediaView.showAddButton = NO;
        }
        
        if (fieldItem.filedImageArray.count > 0) {//请求到的
            NSMutableArray *preShowImageArray = [NSMutableArray array];
            for (HTMIWorkFlowExtModel *extModel in fieldItem.filedImageArray) {
                [preShowImageArray addObject:extModel.file_url];
            }
            mediaView.preShowMedias = preShowImageArray;
        }
        
        switch ([fieldItem.inputString integerValue]) {
            case 6001://单选仅拍照
                mediaView.maxImageSelected = 1;
                mediaView.type = ACMediaTypeCamera;
                
                break;
            case 6002://单选
                mediaView.maxImageSelected = 1;
                mediaView.type = ACMediaTypePhotoAndCamera;
                
                break;
            case 6101://多选仅拍照
                mediaView.type = ACMediaTypeCamera;
                
                break;
            case 6102://多选
                mediaView.type = ACMediaTypePhotoAndCamera;
                
                break;
                
            default:
                break;
        }
        
        mediaView.allowMultipleSelection = NO;
        [view addSubview:mediaView];
        fieldItem.mediaView = mediaView;
        
        __weak typeof (fieldItem) weakfieldItem = fieldItem;
        __weak typeof (self) weakSelf = self;
        [mediaView observeViewHeight:^(CGFloat mediaHeight) {
            
            weakfieldItem.imageHeight = mediaHeight + 20;
            [self.matterFormTableView reloadData];
        }];
        
        
        [mediaView observeItemDelete:^(ACMediaModel_form *model) {
            //如果是网络请求的
            if (model.imageUrlString.length > 0) {
                for (HTMIWorkFlowExtModel *extModel in weakfieldItem.filedImageArray) {
                    if ([model.imageUrlString isEqualToString:extModel.file_url]) {
                        extModel.deleteFlag = YES;
                    }
                }
            }
        }];
        
        [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel_form *> *list) {
            
            //请求到的是URL，所以 mediaModel.imageUrlString 有值的排除，其它上交
            NSMutableArray *imageSelectArray = [NSMutableArray array];
            
            for (ACMediaModel_form *mediaModel in list) {
                if (!mediaModel.imageUrlString) {
                    [imageSelectArray addObject:mediaModel];
                }
            }
            //只是每个item的图片，总的图片得后续处理
            NSLog(@"上交的 ACMediaModel 图片数组：%@",imageSelectArray);
            weakfieldItem.imageArray = imageSelectArray;
            
            if (imageSelectArray.count > 0) {
                fieldItem.valueString = @"已选择";
            } else {
                fieldItem.valueString = @"";
            }
        }];
    } else {
        [view addSubview:fieldItem.mediaView];
    }
    
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
}

@end
