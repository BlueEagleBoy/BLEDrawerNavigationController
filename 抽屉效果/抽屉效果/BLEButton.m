//
//  BLEButton.m
//  抽屉效果
//
//  Created by BlueEagleBoy on 16/1/27.
//  Copyright © 2016年 BlueEagleBoy. All rights reserved.
//

#import "BLEButton.h"

@implementation BLEButton

+ (instancetype)setButtonWithImageName:(NSString *)imageName Title:(NSString *)title {
    
    BLEButton *button = [[BLEButton alloc]init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
    
}

@end
