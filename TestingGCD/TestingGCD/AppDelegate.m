//
//  AppDelegate.m
//  TestingGCD
//
//  Created by iOS-School-1 on 16.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BankomatsViewController.h"
#import "HomeViewController.h"
#import "SegmentedControlPanel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    ViewController *vc = [ViewController new];
//    HomeViewController *vc = [HomeViewController new];
    UITabBarController *tab = [UITabBarController new];

    
    BankomatsViewController *vc = [BankomatsViewController new];
    NSArray *viewControllers = @[vc];
    
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _window.rootViewController = vc;
    
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
