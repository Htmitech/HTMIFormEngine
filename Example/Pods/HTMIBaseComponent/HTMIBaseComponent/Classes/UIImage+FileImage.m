//
//  UIImage+FileImage.m
//  MXClient
//
//  Created by 赵志国 on 2017/3/9.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "UIImage+FileImage.h"

@implementation UIImage (FileImage)

+ (UIImage *)fileImageWithType:(NSString *)typeString {
    
    
    NSString *imageName = [self initImageNameWithTypeString:typeString];
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    return image;
}


+ (NSString *)initImageNameWithTypeString:(NSString *)string {
    NSArray *typeArray = @[@"docx",@"doc",@"DOCX",@"DOC",
                           @"xlsx",@"xls",@"XLSX",@"XLS",
                           @"pptx",@"ppt",@"PPTX",@"PPT",
                           @"txt",@"TXT",@"TEXT",@"text",
                           @"PNG",@"png",@"PDF",@"pdf",
                           @"jpg",@"JPG",@"jpeg",@"JPEG",
                           @"gif",@"GIF",@"rtf",@"xml",@"htm",@"html"];
    
    NSDictionary *allType = @{@"docx":@"icon_docx",
                              @"DOCX":@"icon_docx",
                              @"doc" :@"icon_word",
                              @"DOC" :@"icon_word",
                              @"xlsx":@"icon_excle",
                              @"xls" :@"icon_excle",
                              @"XLSX":@"icon_excle",
                              @"XLS" :@"icon_excle",
                              @"pptx":@"icon_ppt",
                              @"ppt" :@"icon_ppt",
                              @"PPTS":@"icon_ppt",
                              @"PPT" :@"icon_ppt",
                              @"txt" :@"icon_txt",
                              @"text":@"icon_txt",
                              @"TXT" :@"icon_txt",
                              @"TEXT":@"icon_txt",
                              @"png" :@"icon_images",
                              @"jpg" :@"icon_images",
                              @"jpeg":@"icon_images",
                              @"gif" :@"icon_images",
                              @"PNG" :@"icon_images",
                              @"JPG" :@"icon_images",
                              @"JPEG":@"icon_images",
                              @"GIF" :@"icon_images",
                              @"pdf" :@"icon_pdf",
                              @"PDF" :@"icon_pdf",
                              @"rtf" :@"icon_dat",
                              @"xml" :@"icon_dat",
                              @"htm" :@"icon_dat",
                              @"html":@"icon_dat",
                              @"none":@"icon_unkonw"};
    
    NSString *type;
    if (![typeArray containsObject:string]) {
        type = @"none";
    }
    else{
        type = string;
    }
    
    NSString *imageName = [allType objectForKey:type];
    
    return imageName;
}


@end
