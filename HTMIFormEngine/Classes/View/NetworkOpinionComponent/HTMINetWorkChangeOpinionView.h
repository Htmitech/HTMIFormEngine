//
//  HTMINetWorkChangeOpinionView.h
//  MXClient
//
//  Created by 赵志国 on 2017/9/7.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTMIFieldItemModel;

typedef void(^HTMINetWorkChangeOpinionViewEndEditBlock)(NSString *string);

@interface HTMINetWorkChangeOpinionView : UIView

/**
 *  textView编辑完成后收键盘
 */
@property (nonatomic, copy) HTMINetWorkChangeOpinionViewEndEditBlock editEndBlock;

- (instancetype)initWithFrame:(CGRect)frame
                    fieldItem:(HTMIFieldItemModel *)fieldItem
                     textFont:(CGFloat)textFont;

@end
