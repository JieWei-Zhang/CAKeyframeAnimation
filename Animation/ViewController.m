//
//  ViewController.m
//  Animation
//
//  Created by Vinhome on 16/3/24.
//  Copyright © 2016年 Vinhome. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/CALayer.h>
#import <Foundation/NSObject.h>
@interface ViewController ()<UIApplicationDelegate>
{
    BOOL   isclick;
}
@property(nonatomic,strong)CALayer *mask;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIImageView *imgView =[[UIImageView  alloc]initWithFrame:self.view.bounds];
    imgView.image=[UIImage  imageNamed:@"twitterscreen"];
    //
    [self.view addSubview:imgView];
    self.view.backgroundColor=[UIColor colorWithRed:0.117 green:0.631 blue:0.949 alpha:1.0];
    
    
    
    UIButton *btn =[UIButton  buttonWithType:UIButtonTypeSystem];
    btn.center=self.view.center;
    [btn setBackgroundImage:[UIImage  imageNamed:@"profile_btn_unlike@2x"] forState:UIControlStateNormal];
    
    btn.bounds=CGRectMake(0, 0, 50, 50);
    [btn addTarget:self action:@selector(clickme:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    self.mask = [CALayer  layer];;
    self.mask.contents = (__bridge id _Nullable)(([UIImage  imageNamed:@"twitter logo mask"].CGImage));
    self.mask.contentsGravity = kCAGravityResizeAspect;
    self.mask.bounds = CGRectMake( 0,  0,  100, 81);
    self.mask.anchorPoint = CGPointMake( 0.5,  0.5);
    self.mask.position = CGPointMake(imgView.frame.size.width / 2,  imgView.frame.size.height / 2);
    imgView.layer.mask = _mask;
    self.imageView = imgView;
    
    
    //    CGFloat shrinkDuration = 1 * 0.3;
    //    CGFloat growDuration =1* 0.7;
    //
    //    [UIView animateWithDuration:shrinkDuration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.75, 0.75);
    //        imgView.transform = scaleTransform;
    //    } completion:^(BOOL finished) {
    //        [UIView animateWithDuration:growDuration animations:^{
    //            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(20, 20);
    //            imgView.transform = scaleTransform;
    //            imgView.alpha = 0;
    //        } completion:^(BOOL finished) {
    //            //[self removeFromSuperview];
    //        }];
    //    }];
    
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    keyFrameAnimation.delegate = self;
    keyFrameAnimation.duration = 0.6;
    keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5;
    keyFrameAnimation.timingFunctions = @[kCAMediaTimingFunctionEaseInEaseOut,kCAMediaTimingFunctionEaseInEaseOut];
    
    NSValue   *initalBounds =[NSValue valueWithCGRect:_mask.bounds];
    
    NSValue   *secondBounds =[NSValue valueWithCGRect:CGRectMake( 0,  0, 90, 73)];
    NSValue   *finalBounds = [NSValue valueWithCGRect:CGRectMake( 0,  0, 1600, 1300)];
    
    keyFrameAnimation.values = @[initalBounds, secondBounds, finalBounds];
    keyFrameAnimation.keyTimes = @[[NSNumber  numberWithUnsignedInt:0], [NSNumber  numberWithUnsignedInt:0.3],[NSNumber  numberWithUnsignedInt:1]];
    
    keyFrameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    
    //   keyFrameAnimation.rotationMode = kCAAnimationRotateAuto;
    
    
    [self.mask  addAnimation:keyFrameAnimation forKey: @"bounds"];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
-(void)clickme:(UIButton *)btn

{
    isclick=!isclick;
    
    [btn setBackgroundImage:[UIImage  imageNamed:(isclick==YES?@"profile_btn_like@2x":@"profile_btn_unlike@2x")] forState:UIControlStateNormal];
    
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.1),@(1.0),@(1.5)];
    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    
    [btn.layer  addAnimation:k forKey:@"k"];
    
    
    
    CAKeyframeAnimation* bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = @[@1.0 ,@1.4, @0.9, @1.15, ];
    bounceAnimation.duration = 0.5;
    bounceAnimation.calculationMode = kCAAnimationCubic;
    
    [btn.layer addAnimation:bounceAnimation forKey: nil];
    
    
    
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.imageView.layer.mask=nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
