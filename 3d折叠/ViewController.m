//
//  ViewController.m
//  3d折叠
//
//  Created by 1111 on 2017/7/3.
//  Copyright © 2017年 1111. All rights reserved.
//


/*
 思路
 
 
 */

#import "ViewController.h"

@interface ViewController ()
{

    UIButton *firstrbtn;
    UIButton *twobtn;
    UIButton *thrbtn;
    UIButton *fourbtn;


}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    firstrbtn  =[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [firstrbtn setImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    firstrbtn.tag=100;
    
    [firstrbtn addTarget:self action:@selector(firstbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    twobtn =[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    twobtn.tag=101;
    [twobtn setImage:[UIImage imageNamed:@"2.jpg"] forState:UIControlStateNormal];
     [firstrbtn addTarget:self action:@selector(firstbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    thrbtn =[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    thrbtn.tag=102;
    [thrbtn setImage:[UIImage imageNamed:@"3.jpg"] forState:UIControlStateNormal];
    [thrbtn addTarget:self action:@selector(firstbtn:) forControlEvents:UIControlEventTouchUpInside];
 
    thrbtn.selected=YES;
    
    [self.view addSubview:firstrbtn];
      [self.view addSubview:twobtn];
    [self.view addSubview:thrbtn];
  
//    [self.view bringSubviewToFront:thrbtn];
    
    
    
    /*逻辑很简单，没封装如果项目有需求可以自行封装一下。现在主要有一个问题图片翻转以后下边半边会有0.2秒的延迟才能消失不知道什么情况，如果有谁知道的麻烦告知一下🙏q154266797*/
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)firstbtn:(UIButton *)btn{

    
    if (btn.tag==102) {
        if (btn.selected==YES) {
            
            [UIView animateWithDuration:0.2
                                  delay:0
                 usingSpringWithDamping:1.0
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 
                                 twobtn.layer.transform = [self config3DTransformWithRotateAngle:180
                                                                                    andPositionY:100];
                                 firstrbtn.layer.transform = [self config3DTransformWithRotateAngle:180
                                                                                    andPositionY:100];
                                
                             } completion:^(BOOL finished) {
                                 
                                 
                         [UIView animateWithDuration:0.3 animations:^{
                             
                             firstrbtn.layer.transform = [self config3DTransformWithRotateAngle:0
                                                                                   andPositionY:200];
                         }];
                          
                               btn.selected=NO;
                             
                         }];

            
        }if (btn.selected==NO) {
            
            
            [UIView animateWithDuration:0.5
                                  delay:0
                 usingSpringWithDamping:1.0
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{

                                 firstrbtn.layer.transform = [self config3DTransformWithRotateAngle:-180
                                                                                    andPositionY:100];
                                 NSLog(@"111");
       } completion:^(BOOL finished) {
           
           
        [UIView animateWithDuration:0.5 animations:^{
            
            twobtn.layer.transform = [self config3DTransformWithRotateAngle:-360
                                                                                                                         andPositionY:0];
            firstrbtn.layer.transform = [self config3DTransformWithRotateAngle:0
                                                                  andPositionY:0];
            btn.selected=YES;
            NSLog(@"2");
        }];
           
           
                             }];
        }
        
    }

}
- (CATransform3D)config3DTransformWithRotateAngle:(double)angle andPositionY:(double)y
{
    CATransform3D transform = CATransform3DIdentity;
    // 立体
    transform.m34 = -1/1000.0;
    // 旋转
    CATransform3D rotateTransform = CATransform3DRotate(transform, M_PI*angle/180, 1, 0, 0);
    // 移动(这里的y坐标是平面移动的的距离,我们要把他转换成3D移动的距离.这是关键,没有它图片就没办法很好地对接。)
    CATransform3D moveTransform = CATransform3DMakeAffineTransform(CGAffineTransformMakeTranslation(0, y));
    // 合并
    CATransform3D concatTransform = CATransform3DConcat(rotateTransform, moveTransform);
    return concatTransform;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
