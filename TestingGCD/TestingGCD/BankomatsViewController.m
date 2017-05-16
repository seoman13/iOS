//
//  BankomatsViewController.m
//  TestingGCD
//
//  Created by iOS-School-1 on 16.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "BankomatsViewController.h"
#import <MapKit/MapKit.h>

@interface BankomatsViewController ()

@end

@implementation BankomatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MKMapView *map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:map];
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

@end
