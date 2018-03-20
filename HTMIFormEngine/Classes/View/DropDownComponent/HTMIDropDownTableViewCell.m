//
//  HTMIDropDownTableViewCell.m
//  MXClient
//
//  Created by 赵志国 on 16/6/27.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import "HTMIDropDownTableViewCell.h"

#import "UtilsMacros.h"

#import "UIFont+HTMIFont.h"

@implementation HTMIDropDownTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier labelString:(NSString *)labelString labelFont:(CGFloat)labelFont width:(CGFloat)cellWidth {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(kW6(12), 0, cellWidth-kW6(12)*2, kH6(40))];
        self.label.text = labelString;
        self.label.font = [UIFont htmi_systemFontOfSize:labelFont];
        [self.contentView addSubview:self.label];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
