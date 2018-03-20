//
//  HTMINetworkTextView.h
//  MXClient
//
//  Created by 赵志国 on 2017/8/29.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HTMITextViewEndEditBlock)(NSString *string);

@interface HTMINetworkTextView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                   nameString:(NSString *)nameString
                  valueString:(NSString *)valueString
                  isMustInput:(BOOL)isMustInput
                     textFont:(CGFloat)textFont;
/**
 *  textView编辑完成后收键盘
 */
@property (nonatomic, copy) HTMITextViewEndEditBlock editEndBlock;

@end
