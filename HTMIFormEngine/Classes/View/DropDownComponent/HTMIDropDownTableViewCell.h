//
//  HTMIDropDownTableViewCell.h
//  MXClient
//
//  Created by 赵志国 on 16/6/27.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMIDropDownTableViewCell : UITableViewCell

@property (strong,nonatomic)UILabel *label;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier labelString:(NSString *)labelString labelFont:(CGFloat)labelFont width:(CGFloat)cellWidth;

@end
