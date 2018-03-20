//
//  UIImage+Hub.m
//  HTMIFormComponent
//
//  Created by 赵志国 on 2018/3/16.
//  Copyright © 2018年 htmitech.com. All rights reserved.
//

#import "UIImage+Hub.h"

#import "HTMIApplicationHubManager.h"

#import "HTMISettingManager.h"

@implementation UIImage (Hub)

/**
 *  获取图片，根据当前的色调
 *
 *  @param imageName 图片名
 *
 *  @return 图片
 */
+ (UIImage *)engine_imageWithViewHue:(NSString *)imageName{
    
    NSMutableString * imageNameEndString = [NSMutableString stringWithString:imageName];
    
    HTMIApplicationHueType type = [HTMIApplicationHubManager manager].applicationHubType;
    
    if (type == HTMIApplicationHueWhite) {
        [imageNameEndString appendString:@"_blue"];
    }
    else if(type == HTMIApplicationHueRed) {
        [imageNameEndString appendString:@"_red"];
    }
    else if(type == HTMIApplicationHueBlue) {
        [imageNameEndString appendString:@"_blue"];
    }
    
    UIImage * image = [[self class]imageNamed:imageNameEndString];
    
    return image;
}

/**
 *  导航栏获取图片，根据当前的色调
 *
 *  @param imageName 图片名
 *
 *  @return 图片
 */
+ (UIImage *)engine_imageNavigationWithViewHue:(NSString *)imageName{
    
    NSMutableString * imageNameEndString = [NSMutableString stringWithString:imageName];
    
    HTMIApplicationHueType type = [HTMIApplicationHubManager manager].applicationHubType;
    
    if (type == HTMIApplicationHueWhite) {
        [imageNameEndString appendString:@"_white"];
    }
    else {
        [imageNameEndString appendString:@"_blue"];
    }
    
    UIImage * image = [[self class] imageNamed:imageNameEndString];
    
    return image;
}


@end
