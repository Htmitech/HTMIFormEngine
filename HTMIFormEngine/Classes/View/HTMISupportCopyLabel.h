//
//  HTMISupportCopyLabel.h
//  MXClient
//
//  Created by wlq on 2017/6/9.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTMIFieldItemModel;

@interface HTMISupportCopyLabel : UILabel

+ (HTMISupportCopyLabel *)creatLabelWithFrame:(CGRect)frame text:(NSString *)text alingment:(NSString *)alignment textColor:(NSInteger)textColor fontSize:(CGFloat)fontSize;


/**
 工作流的

 @param fieldItem <#fieldItem description#>
 @param nameString <#nameString description#>
 @param valueString <#valueString description#>
 @param width <#width description#>
 @param cellHeight <#cellHeight description#>
 @param superView <#superView description#>
 @param fontSize <#fontSize description#>
 */
+ (void)inputNoEditFieldItem:(HTMIFieldItemModel *)fieldItem nameString:(NSString *)nameString valueString:(NSString *)valueString width:(CGFloat)width cellHeight:(CGFloat)cellHeight superView:(UIView *)superView fontSize:(CGFloat)fontSize;

@end
