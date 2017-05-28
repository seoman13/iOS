//
//  ViewController.m
//  lesson9
//
//  Created by iOS-School-1 on 18.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerNext.h"

@interface ViewController ()

@property(nonatomic, weak) IBOutlet UIButton *button;

@end

@implementation ViewController

-(instancetype)init{
    self = [super init];
    if(self){
        self.tabBarItem.title = @"First Controller";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:4];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonTapped:(id)sender{
    ViewControllerNext *vc = [ViewControllerNext new];
    vc.view.backgroundColor = [UIColor cyanColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
