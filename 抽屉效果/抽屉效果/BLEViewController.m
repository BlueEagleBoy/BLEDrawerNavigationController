//
//  BLEViewController.m
//  抽屉效果
//
//  Created by BlueEagleBoy on 16/1/24.
//  Copyright © 2016年 BlueEagleBoy. All rights reserved.
//

#import "BLEViewController.h"
#define identifier @"cell_id"

@interface BLEViewController ()

@end

@implementation BLEViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"IconSettings"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickLeftBarButtonItem:)];

    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    

    
    
}

- (void)didClickLeftBarButtonItem:(UIBarButtonItem *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"didLeftView" object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
   cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    
    return cell;
}

//- (BOOL)prefersStatusBarHidden {
//    
//    return YES;
//}



@end
