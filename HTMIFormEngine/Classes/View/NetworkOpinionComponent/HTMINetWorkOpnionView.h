//
//  HTMINetWorkOpnionView.h
//  MXClient
//
//  Created by 赵志国 on 2017/9/6.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTMIFieldItemModel;

typedef void(^HTMINetWorkOpnionViewEndEditBlock)(NSString *string);

@interface HTMINetWorkOpnionView : UIView

/**
 *  textView编辑完成后收键盘
 */
@property (nonatomic, copy) HTMINetWorkOpnionViewEndEditBlock editEndBlock;

- (instancetype)initWithFrame:(CGRect)frame
                   fieldItem:(HTMIFieldItemModel *)fieldItem
                     textFont:(CGFloat)textFont;

@end
