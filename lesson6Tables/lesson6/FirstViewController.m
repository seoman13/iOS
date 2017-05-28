//
//  ViewController.m
//  lesson6
//
//  Created by iOS-School-1 on 11.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

-(instancetype)init{
    self = [super init];
    if(self){
        self.tabBarItem.title = @"FirstVC";
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -6);
        self.navigationItem.title = @"First screen";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.yellowColor;
    self.tabBarItem.title = @"FirstVC";
    
//    UIButton *btn = [UIButton new];
//    CGRect bounds = self.view.bounds;
//    btn.frame = CGRectMake(bounds.size.width / 2 - 50, bounds.size.height / 2 - 20, 100, 40);
//    btn.backgroundColor = UIColor.redColor;
//    [btn setTitle:@"Move" forState:UIControlStateNormal];
//    [btn setTitleColor:UIColor.yellowColor forState:UIControlStateHighlighted];
//    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
}

//-(void) buttonClick:(UIButton *)button{
//    SecondViewController *vc = [SecondViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
//}



@end
