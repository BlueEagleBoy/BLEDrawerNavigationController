//
//  BLETableView.m
//  抽屉效果
//
//  Created by BlueEagleBoy on 16/1/27.
//  Copyright © 2016年 BlueEagleBoy. All rights reserved.
//

#import "BLETableView.h"

@interface BLETableView ()<UITableViewDataSource>

@end

@implementation BLETableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.contentInset = UIEdgeInsetsMake( 10, 30, -100, -30);
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.backgroundColor = [UIColor blueColor];

    }
    
    return self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell_id";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    cell.imageView.image = [UIImage imageNamed:@"IconCalendar"];
    
    cell.textLabel.text = @"开通会员";
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}





@end
