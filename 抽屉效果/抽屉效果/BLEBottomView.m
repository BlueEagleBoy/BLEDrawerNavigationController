//
//  BLEBottomView.m
//  抽屉效果
//
//  Created by BlueEagleBoy on 16/1/27.
//  Copyright © 2016年 BlueEagleBoy. All rights reserved.
//

#import "BLEBottomView.h"
#import "Masonry.h"
#import "BLEButton.h"

@interface BLEBottomView ()

@property (nonatomic, strong)UIButton *setting;
@property (nonatomic, strong)UIButton *nightBtn;

@end

@implementation BLEBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blueColor];
        
        BLEButton *setting = [BLEButton setButtonWithImageName:@"IconSettings" Title:@"设置"];
        [setting setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.setting = setting;
        [setting setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
     
        [setting addTarget:self action:@selector(didClickSetting:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        BLEButton *nightBtn = [BLEButton setButtonWithImageName:@"IconHome" Title:@"夜间"];
        self.nightBtn = nightBtn;
        [nightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        
        [self addSubview:setting];
        [self addSubview:nightBtn];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.setting mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self).offset(30);
        make.bottom.equalTo(self).offset(-20);
        
    }];
    
    [self.nightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.setting);
        make.centerX.equalTo(self);
    }];
    
}

- (void)didClickSetting:(UIButton *)sender {
    
    UIViewController *view = [[UIViewController alloc]init];
    
    //点击设置弹出一个控制器让给控制器发送一个通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BLELeftViewSettingNotification" object:nil];
    
}





@end
