# BLEDrawerNavigationController


###仿QQ抽屉效果


效果展示:

![](http://a.picphotos.baidu.com/album/s%3D680%3Bq%3D90/sign=f541bfba44166d223c77169c761878ca/a71ea8d3fd1f413437b03d0f221f95cad1c85e3f.jpg)



－QQ效果描述：QQ中的效果是侧滑的效果，当导航控制器从左侧画开的时候，左侧的视图也跟着有稍许的滑动。（注意：在这里左侧View你即可以添加一viewController，也可以添加一个view）。

- 实现思想：

  - 侧滑：
  
  	* 方法1:
  	
  	这种稍微有点复杂，侧滑我是在导航控制器的view添加一个拖拽手势，然后在手势的触发中，判断开始滑动的位置是否在左侧70个点内,如果在该范围内就可以滑动并修改导航控制view的transform，否则不能滑动。
  
  	* 方法2:
 
 	直接使用苹果原生的API 一个屏幕侧滑手势
  
  ```
  UIScreenEdgePanGestureRecognizer *screenPan = [UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:);
    screenPan.edges = UIRectEdgeLeft;
  ```
  
  -  定义一个枚举，用来定义导航控制器滑动的开始位置和结束位置。
  
  ```
  typedef enum {
  
    BLEViewTransformLocationOriginal,
    BLEViewTransformLocationLeft
    
    }BLEViewTransformLocation;


  ``` 
  
   - 左侧View的联动：我直接在手势的代理方法中，在改变导航控制器view的transform的同时，也以一定的比例改变左侧view的transform   
   
   ```
  
   //手势触发方法
-(void)panGesture:(UIGestureRecognizer *)gesture {
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

   ```
  
  - 遮罩view：当滑动到最右侧后，就添加一个透明遮罩，点击遮罩，就设置transformLocation 为 BLEViewTransformLocationOriginal，返回到原始位置
  
  ```
  -(void)didClickCoverButton{
    
    self.transformLocation = BLEViewTransformLocationOriginal;
}
  
  ```
 
  
总结：主要思想就上面那么多，代码很简单，大家可以用苹果自带的侧滑手势，用一下更加简洁。
 
 