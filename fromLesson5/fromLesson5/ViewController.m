//
//  ViewController.m
//  fromLesson5
//
//  Created by Admin on 11.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    UITextField *_txtareaname, *_txtareapwd;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [UIView new];
    CGRect bounds = UIScreen.mainScreen.bounds;
    view.frame = CGRectMake(0, 0, bounds.size.width,bounds.size.height);
    //[self.view addSubview:view];
    
    UIView *thirdView = [UIView new];
    CGFloat width = bounds.size.width / 6;
    CGFloat height = bounds.size.height / 12;
//    thirdView.frame = CGRectMake(bounds.size.width / 2 - 20, bounds.size.height / 2 - 20, 40, 40);
    thirdView.frame = CGRectMake(width * 3 - width / 2, height * 5 - height / 2, width, height);
    thirdView.backgroundColor = UIColor.blueColor;
    thirdView.layer.masksToBounds = YES;
    thirdView.layer.cornerRadius = thirdView.bounds.size.width / 2;
    thirdView.layer.shouldRasterize = YES;
    [self.view addSubview:thirdView];
    
    self.view.backgroundColor = UIColor.greenColor;
    
    _txtareaname = [UITextField new];
    _txtareaname.backgroundColor = UIColor.whiteColor;
    _txtareaname.frame = CGRectMake(50, 50, 200, 50);
    _txtareapwd = [UITextField new];
    _txtareapwd.backgroundColor = UIColor.whiteColor;
    _txtareapwd.frame = CGRectMake(50, 150, 200, 50);
    
    [self.view addSubview:_txtareaname];
    [self.view addSubview:_txtareapwd];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(50, 250, 80, 40);
    [btn setTitle:@"Entry" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(tap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)btnClicked:(UIButton *)sender {
    NSLog(@"%@", _txtareaname.text);
    NSLog(@"%@", _txtareapwd.text);
    
    NSString *tmp = _txtareaname.text;
    _txtareaname.text = _txtareapwd.text;
    _txtareapwd.text = tmp;
}

-(void)tap:(UITapGestureRecognizer *)tap{
    
}


@end
