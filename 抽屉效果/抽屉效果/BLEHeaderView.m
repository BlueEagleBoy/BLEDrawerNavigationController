//
//  BLEHeaderView.m
//  抽屉效果
//
//  Created by BlueEagleBoy on 16/1/26.
//  Copyright © 2016年 BlueEagleBoy. All rights reserved.
//

#import "BLEHeaderView.h"
#import "Masonry.h"

@interface BLEHeaderView ()

@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *detailText;

@end

@implementation BLEHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor magentaColor];
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.icon.image = [UIImage imageNamed:@"IconProfile"];
        self.icon.layer.cornerRadius = 25;
        self.icon.layer.masksToBounds = YES;
        _nameLabel = [[UILabel alloc]init];
        self.nameLabel.text = @"后街男孩";
        _detailText =  [[UILabel alloc]init];
        self.detailText.text = @"不是我们没有努力，而是我们的努力不够,而是我们的努力不够,而是我们的努力不够";
        
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self addSubview:self.icon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.detailText];

    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(30);
        make.centerY.equalTo(self);
        make.width.equalTo(@50);
        make.height.equalTo(@50);

    }];
    

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.icon);
        make.leading.equalTo(self.icon.mas_trailing).offset(15);
    }];
    
    [self.detailText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.icon.mas_bottom).offset(8);
        make.leading.equalTo(self.icon);
        make.width.equalTo(@300);
        
    }];
    
}



@end
