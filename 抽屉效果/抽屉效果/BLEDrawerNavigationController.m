//
//  BLEDrawerNavigationController.m
//  抽屉效果
//
//  Created by BlueEagleBoy on 16/1/24.
//  Copyright © 2016年 BlueEagleBoy. All rights reserved.
//

#import "BLEDrawerNavigationController.h"
#import "BLELeftView.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#import <CoreLocation/CoreLocation.h>


typedef enum {
    
    BLEViewTransformLocationOriginal,
    BLEViewTransformLocationLeft
    
}BLEViewTransformLocation;


@interface BLEDrawerNavigationController ()<UIGestureRecognizerDelegate>

//导航控制器的leftBarItem
@property (nonatomic, assign)BOOL isLeft;
//上一次拖拽的x位置
@property (nonatomic, assign)CGFloat lastPanTouchX;

//设置导航控制的view的tranform位置
@property (nonatomic, assign)BLEViewTransformLocation transformLocation;

//停留在右侧时的遮罩 用来点击会退
@property (nonatomic, strong)UIView *coverView;
//左侧view
@property (nonatomic, weak)BLELeftView *leftView;

@end

@implementation BLEDrawerNavigationController

//当设置transformLocation值的时候就做相应的更改
- (void)setTransformLocation:(BLEViewTransformLocation)transformLocation{
    
    CGAffineTransform transform ;
    CGAffineTransform leftViewTransform;
    if (transformLocation == BLEViewTransformLocationOriginal) {
        
        [self.coverView removeFromSuperview];
        //view的transform
        transform = CGAffineTransformIdentity;
        //左侧view的transform
        leftViewTransform = CGAffineTransformIdentity;
        
    }else  {
        
        [self.view addSubview:self.coverView];
        
        transform = CGAffineTransformMakeTranslation(BLETransformMaxW, 0);
        
        leftViewTransform = CGAffineTransformMakeTranslation(BLETransformMaxW * 0.3, 0);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        //动画设置transform
        self.leftView.transform = leftViewTransform;
        
        self.view.transform = transform;
    }];
}

//在将要显示的时候添加一个左侧view
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    BLELeftView *leftView = [[BLELeftView alloc]initWithFrame:CGRectMake(- wm_ScreenWidth + 300, 0, wm_ScreenWidth, wm_ScreenHeight)];
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window  addSubview:leftView];
    
    self.leftView = leftView;
    
}


- (void)viewDidLoad {

    [super viewDidLoad];

    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    
    [self.view addGestureRecognizer:gesture];
    
    gesture.delegate = self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickBlueButton) name:@"didLeftView" object:nil];
    
    UIButton *view = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,BLEGestureMaxX, wm_ScreenHeight)];
    
    [view addTarget:self action:@selector(didClickCoverButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.coverView = view;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickSettingPushController) name:@"BLELeftViewSettingNotification" object:nil];
}

#pragma mark 监听左侧视图中的设置按钮点击方法
- (void)didClickSettingPushController {
    
    UIViewController *vc = [[UIViewController alloc]init];
    
    [self pushViewController:vc animated:YES];
    
    self.transformLocation = BLEViewTransformLocationOriginal;
    
    vc.view.backgroundColor = [UIColor redColor];
}

- (void)didClickCoverButton{
    
    self.transformLocation = BLEViewTransformLocationOriginal;
}


//手势触发方法
- (void)panGesture:(UIGestureRecognizer *)gesture {
    
    CGFloat panTouchX = [gesture locationInView:self.view].x;
    
    //当满足手势在哪个范围时才有处罚手势
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        if (panTouchX <= BLEGestureMaxX) {
            
            self.lastPanTouchX = panTouchX;
        }
    }
    //判断是否满足拖拽条件范围
    if (self.lastPanTouchX != 0) {
       
        CGPoint currentPoint = [gesture locationInView:self.view];
        
        CGFloat translateDist = currentPoint.x - self.lastPanTouchX;
        
        CGFloat nextTransformX = self.view.transform.tx + translateDist;
        //判断是否会超出左侧view
        if (nextTransformX <= 0) {
            
            self.transformLocation = BLEViewTransformLocationOriginal;
            //判断是否会超出左侧预留的宽度范围
        }else if (nextTransformX >= BLETransformMaxW) {
            
            self.transformLocation = BLEViewTransformLocationLeft;
            
        }else {
            
            self.leftView.transform = CGAffineTransformTranslate(self.leftView.transform, translateDist * 0.3, 0);
    
            self.view.transform = CGAffineTransformTranslate(self.view.transform, translateDist, 0);
        }
        
    }
    
    //当拖拽结束的时候会到原始位置
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        self.transformLocation = self.view.transform.tx <  BLETransformMaxW * 0.5 ? BLEViewTransformLocationOriginal : BLEViewTransformLocationLeft;
    
        self.lastPanTouchX = 0;

    }
}

- (void)didClickBlueButton {

    if (!self.isLeft) {
        self.transformLocation = BLEViewTransformLocationLeft;
        
        
    }else {
        self.transformLocation = BLEViewTransformLocationOriginal;
    }
    
    self.isLeft = !self.isLeft;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
