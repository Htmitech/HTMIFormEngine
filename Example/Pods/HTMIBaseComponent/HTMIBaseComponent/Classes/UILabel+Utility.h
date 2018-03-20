//
//  UILabel+Utility.h
//  MXClient
//
//  Created by wlq on 16/6/15.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utility)

- (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font;

- (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;

@end
