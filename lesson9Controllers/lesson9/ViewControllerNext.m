//
//  ViewControllerNextViewController.m
//  lesson9
//
//  Created by iOS-School-1 on 18.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ViewControllerNext.h"

@interface ViewControllerNext ()
@property(nonatomic, strong) UIButton *buttonBack;

@end

@implementation ViewControllerNext

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 100, 30)];
    self.buttonBack.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.buttonBack];
    [self.buttonBack addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)backButtonTapped:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
