//
//  ViewController.m
//  TestingPatterns
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "Singleton.h"
#import "Button.h"
#import "Observer.h"

@interface ViewController () <ObserverProtocol>

@property (nonatomic, strong) Observer *observer;

@end

@implementation ViewController

- (void)dealloc {
    [_observer removeAllObservers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.bounds.size.width / 2 - 20, 100, 40, 20);
    [btn setTitle:@"Click" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    Button *addButton = [Button buttonWithType:ButtonTypeAdd];
    [addButton draw];
    [addButton size];
    
    self.observer = [Observer new];
    [_observer addObserver:self forEvent:EventTypeAddItem];
    [_observer addObserver:self forEvent:EventTypeRemoveItem];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observe:) name:nil object:nil];
}

- (void)buttonClicked:(UIButton *)sender {
    [_observer sendEvent:EventTypeAddItem];
    [_observer sendEvent:EventTypeRemoveItem];
    [_observer sendEvent:EventTypeUpdateItem];
}

#pragma mark - ObserverProtocol
- (void)didRecieveEvent:(EventType)type {
    NSLog(@"%@", @(type));
}

//- (void)observe:(NSNotification *)notification {
//    NSLog(@"%@", notification.description);
//}

//- (void)buttonClicked:(UIButton*)sender {
//    [Singleton sharedInstance];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
