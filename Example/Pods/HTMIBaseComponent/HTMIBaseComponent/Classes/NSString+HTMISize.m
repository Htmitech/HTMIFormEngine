//
//  NSString+HTMISize.m
//  MXClient
//
//  Created by wlq on 2017/7/31.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "NSString+HTMISize.h"

#import "UIFont+HTMIFont.h"

@implementation NSString (HTMISize)

//用对象的方法计算文本的大小
- (CGSize)htmi_sizeWithFont:(UIFont*)font maxSize:(CGSize)size {
    //特殊的格式要求都写在属性字典中
    NSDictionary*attrs =@{NSFontAttributeName: font};
    //返回一个矩形，大小等于文本绘制完占据的宽和高。
    return  [self  boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:attrs   context:nil].size;
}

+ (CGSize)htmi_sizeWithString:(NSString*)str font:(UIFont*)font maxSize:(CGSize)size{
    NSDictionary*attrs =@{NSFontAttributeName: font};
    return  [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs  context:nil].size;
}


+ (CGSize)labelSizeWithMaxWidth:(CGFloat)width content:(NSString *)content FontOfSize:(CGFloat)FontOfSize {
    if (content.length < 1) {
        return CGSizeMake(0, 0);
    }
    
    NSDictionary *dic = @{NSFontAttributeName: [UIFont htmi_systemFontOfSize:FontOfSize]};
    //HTMISupportCopyLabel根据内容自适应大小
    //参数1:宽高限制   参数2:附加   参数3:计算时只用到font就OK     参数4:nil
    return [content boundingRectWithSize:CGSizeMake(width, 0)
                                 options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                              attributes:dic
                                 context:nil].size;

    
    return CGSizeMake(0, 0);
}

@end
