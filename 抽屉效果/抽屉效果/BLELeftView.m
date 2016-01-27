//
//  BLELeftView.m
//  抽屉效果
//
//  Created by BlueEagleBoy on 16/1/26.
//  Copyright © 2016年 BlueEagleBoy. All rights reserved.
//

#import "BLELeftView.h"
#import "BLEHeaderView.h"
#import "BLETableView.h"
#import "BLEBottomView.h"
#define wm_screenWidth [UIScreen mainScreen].bounds.size.width
#define wm_screenHeight [UIScreen mainScreen].bounds.size.height

@interface BLELeftView ()



@end

@implementation BLELeftView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        
        //添加头部视图
        BLEHeaderView *headerView = [[BLEHeaderView alloc]initWithFrame:CGRectMake(10, 0, BLETransformMaxW, wm_HeaderViewHeight)];
        
        //添加中间视图
        BLETableView *tableView = [[BLETableView alloc]initWithFrame:CGRectMake(0, wm_HeaderViewHeight,BLETransformMaxW , wm_screenHeight-wm_LeftViewBottomHeight - wm_HeaderViewHeight) style:UITableViewStylePlain];
        
        //添加底部视图
        BLEBottomView *bottomView = [[BLEBottomView alloc]initWithFrame:CGRectMake(10, wm_ScreenHeight - wm_LeftViewBottomHeight, BLETransformMaxW,wm_LeftViewBottomHeight)];

        [self addSubview:headerView];
        [self addSubview:tableView];
        [self addSubview:bottomView];
        [self bringSubviewToFront:headerView];
        [self bringSubviewToFront:bottomView];
        

    }
    
    return self;
}




@end
