//
//  HTMIOpinionAutographView.m
//  HTMIOpinionAutographView
//
//  Created by 赵志国 on 16/6/28.
//  Copyright © 2016年 htmitech.com. All rights reserved.
//

#import "HTMIOpinionAutographView.h"

#import "UtilsMacros.h"

#import "UIFont+HTMIFont.h"

@interface HTMIOpinionAutographView ()

@property (nonatomic, strong) UIButton *autographBtn;

@property (nonatomic, strong) UIButton *opinionBtn;

@end

@implementation HTMIOpinionAutographView

- (instancetype)initWithFrame:(CGRect)frame selectType:(SelectType)selectType aOro:(NSString *)aOrO {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *opinionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kW6(57), 0, 35, kH6(50))];
        opinionLabel.text = FormGetHTMILocalString(@"htmi_common_signature");
        opinionLabel.font = [UIFont htmi_systemFontOfSize:15.0];
        [self addSubview:opinionLabel];
        
        UILabel *autographLabel = [[UILabel alloc] init];
        autographLabel.text = FormGetHTMILocalString(@"htmi_screenshot_opinion");
        autographLabel.font = [UIFont htmi_systemFontOfSize:15.0];
        if (selectType == HorizontalType) {
            autographLabel.frame = CGRectMake(kW6(144), 0, 35, kH6(50));
            
        } else if (selectType == VerticalType) {
            autographLabel.frame = CGRectMake(kW6(57), kH6(50), 35, kH6(50));
        }
        [self addSubview:autographLabel];
        
        
        self.autographBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.autographBtn.frame = CGRectMake(kW6(20), kH6(12.5), kW6(25), kH6(25));
        if ([aOrO isEqualToString:FormGetHTMILocalString(@"htmi_common_signature")]) {
            [self.autographBtn setBackgroundImage:[UIImage imageNamed:@"btn_radio_selected"] forState:UIControlStateNormal];
        } else {
            [self.autographBtn setBackgroundImage:[UIImage imageNamed:@"btn_radio_normal"] forState:UIControlStateNormal];
        }
        self.autographBtn.tag = 0;
        [self.autographBtn addTarget:self action:@selector(opinionOrAutoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.autographBtn];
        
        
        self.opinionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        if (selectType == HorizontalType) {
            self.opinionBtn.frame = CGRectMake(kW6(107), kH6(12.5), kW6(25), kH6(25));
            
        } else if (selectType == VerticalType) {
            self.opinionBtn.frame = CGRectMake(kW6(20), kH6(62.5), kW6(25), kH6(25));
        }
        if ([aOrO isEqualToString:FormGetHTMILocalString(@"htmi_screenshot_opinion")]) {
            [self.opinionBtn setBackgroundImage:[UIImage imageNamed:@"btn_radio_selected"] forState:UIControlStateNormal];
        } else {
            [self.opinionBtn setBackgroundImage:[UIImage imageNamed:@"btn_radio_normal"] forState:UIControlStateNormal];
        }
        
        self.opinionBtn.tag = 1;
        [self.opinionBtn addTarget:self action:@selector(opinionOrAutoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.opinionBtn];
    }
    
    return self;
}

- (void)opinionOrAutoBtnClick:(UIButton *)btn {
    if (btn.tag == 0) {
//        [self.autographBtn setBackgroundImage:[UIImage imageNamed:@"btn_radio_selected"] forState:UIControlStateNormal];
//        
//        [self.opinionBtn setBackgroundImage:[UIImage imageNamed:@"btn_radio_normal"] forState:UIControlStateNormal];
        
        self.buttonClickBlock(FormGetHTMILocalString(@"htmi_common_signature"));
        
    } else if (btn.tag == 1) {
//        [self.opinionBtn setBackgroundImage:[UIImage imageNamed:@"btn_radio_selected"] forState:UIControlStateNormal];
//        
//        [self.autographBtn setBackgroundImage:[UIImage imageNamed:@"btn_radio_normal"] forState:UIControlStateNormal];
        
        self.buttonClickBlock(FormGetHTMILocalString(@"htmi_screenshot_opinion"));
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
