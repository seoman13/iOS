//
//  ThirdViewController.m
//  lesson6
//
//  Created by iOS-School-1 on 11.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ThirdViewController.h"
#import "SecondViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

-(instancetype)init{
    self = [super init];
    if(self){
//        self.tabBarItem.title = @"ThirdVC";
//        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -6);
        self.navigationItem.title = @"Third screen";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.tabBarItem.title = @"ThirdVC";
    
    UIButton *btn1 = [UIButton new];
    CGRect bounds = self.view.bounds;
    btn1.frame = CGRectMake(bounds.size.width / 2 - 50, bounds.size.height / 2 - 20, 100, 40);
    btn1.backgroundColor = UIColor.blueColor;
    [btn1 setTitle:@"Push" forState:UIControlStateNormal];
    [btn1 setTitleColor:UIColor.yellowColor forState:UIControlStateHighlighted];
    [btn1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [UIButton new];
    btn2.frame = CGRectMake(bounds.size.width / 2 - 50, bounds.size.height / 2 + 20, 100, 40);
    btn2.backgroundColor = UIColor.greenColor;
    [btn2 setTitle:@"Pop" forState:UIControlStateNormal];
    [btn2 setTitleColor:UIColor.yellowColor forState:UIControlStateHighlighted];
    [btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

    
}

-(void) button2Click:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
    }

-(void) button1Click:(UIButton *)button{
    ThirdViewController *vc = [ThirdViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
