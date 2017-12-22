//
//  AnimationViewController.m
//  TestingCoreAnimation
//
//  Created by Admin on 09.12.17.
//  Copyright © 2017 crest. All rights reserved.
//

#import "AnimationViewController.h"
#import <QuartzCore/QuartzCore.h>
@import OpenGLES;


@interface AnimationViewController ()

@property (nonatomic, strong) UIButton *button;

@end


@implementation AnimationViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tabBarItem.title = @"Test Core Animation";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(20, CGRectGetHeight(self.view.bounds) / 2 - 25, 120, 50);
    [self.button setTitle:@"My Button" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.button.layer.backgroundColor = UIColor.yellowColor.CGColor;
    [self.button.layer addAnimation:[self circularMovementAnimation] forKey:@"basic"];
    [self.view addSubview:self.button];
}

- (void)buttonTapped:(UIButton *)sender {
//    [self.button.layer addAnimation:[self circularMovementAnimation] forKey:@"basic"];
//    [self.view.layer addAnimation:[self colorChangeAnimation] forKey:@"basic"];
}

- (CABasicAnimation *)colorChangeAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.duration = 5.0;
    animation.fromValue = (id)UIColor.greenColor.CGColor;
    animation.toValue = (id)UIColor.redColor.CGColor;
    animation.autoreverses = YES;
    animation.repeatCount = 20;
    
    return animation;
}

- (CABasicAnimation *)circularMovementAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @20;
    animation.toValue = @500;
    animation.duration = 10;
    
    return animation;
}

@end
