//
//  UIView+BorderView.m
//  HTMIFormComponent
//
//  Created by 赵志国 on 2018/3/16.
//  Copyright © 2018年 htmitech.com. All rights reserved.
//

#import "UIView+BorderView.h"

@implementation UIView (BorderView)

/**
 *  边框
 */
+ (UIView *)creatBorderViewFrame:(CGRect)frame {
    UIView *borderView = [[UIView alloc] initWithFrame:frame];
    borderView.userInteractionEnabled = YES;
    borderView.layer.borderWidth = 1.0;
    borderView.layer.borderColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor;
    borderView.layer.masksToBounds = YES;
    borderView.layer.cornerRadius = 2.0;
    
    return borderView;
}

@end
