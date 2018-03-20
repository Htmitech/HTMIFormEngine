//
//  UIImage+Hub.h
//  HTMIFormComponent
//
//  Created by 赵志国 on 2018/3/16.
//  Copyright © 2018年 htmitech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Hub)

/**
 *  获取图片，根据当前的色调
 *
 *  @param imageName 图片名
 *
 *  @return 图片
 */
+ (UIImage *)engine_imageWithViewHue:(NSString *)imageName;

/**
 *  导航栏获取图片，根据当前的色调
 *
 *  @param imageName 图片名
 *
 *  @return 图片
 */
+ (UIImage *)engine_imageNavigationWithViewHue:(NSString *)imageName;


@end
