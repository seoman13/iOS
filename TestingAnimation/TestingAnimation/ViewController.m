//
//  ViewController.m
//  TestingAnimation
//
//  Created by iOS-School-1 on 03.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *myView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat width = 100;
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - width / 2, self.view.bounds.size.height / 2 - 2 * width, width, width)];
//    btn1.layer.style = UIButtonTypeRoundedRect;
    btn1.layer.cornerRadius = width / 2;
    btn1.backgroundColor = [UIColor blueColor];
    btn1.titleLabel.text = @"Disappear";
    btn1.titleLabel.textColor = [UIColor blackColor];
//    [btn1 addTarget:self action:@selector(disappearAnimation:) forControlEvents:UIControlEventTouchUpInside];
//    [btn1 addTarget:self action:@selector(flyawayView:) forControlEvents:UIControlEventTouchUpInside];
//    [btn1 addTarget:self action:@selector(shakeView:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 addTarget:self action:@selector(floatView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - width / 2, self.view.bounds.size.height / 2 + width, width, width)];
    btn2.layer.cornerRadius = width / 2;
    btn2.backgroundColor = [UIColor magentaColor];
    btn2.titleLabel.text = @"Magenta";
    [btn2 addTarget:self action:@selector(turnView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - width / 2, self.view.bounds.size.width / 2 + width, width, width)];
    self.myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.myView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)disappearAnimation:(UIButton *)button {
    if (self.myView.alpha > 0.0) {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.myView.alpha = 0.0;
        } completion:^(BOOL finished){
//            NSLog(@"");
        }];
    } else {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.myView.alpha = 1.0;
        } completion:^(BOOL finished){
            
        }];
    }
    
}

- (void)turnView:(UIButton *)button {
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGAffineTransform transform = CGAffineTransformIdentity;
        self.myView.transform = CGAffineTransformRotate(transform, 90);
    } completion:^(BOOL finished){
//        self.myView.transform = 0.0;
    }];
}

- (void)flyawayView:(UIButton *)button {
    [UIView animateWithDuration:1.0 animations:^{
        self.myView.center = CGPointMake(0, 0);
    }];
}

- (void)shakeView:(UIButton *)button {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    
    animation.additive = YES;
    
    [self.myView.layer addAnimation:animation forKey:@"shake"];
}

- (void)floatView:(UIButton *)button {
    CGRect boundingRect = CGRectMake(-150, -150, 300, 300);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
//    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.path = CFAutorelease(CGPathCreateWithRect(boundingRect, NULL));
//    orbit.path = CGPathIsRect(, boundingRect);
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    
    [self.myView.layer addAnimation:orbit forKey:@"orbit"];
}

@end
