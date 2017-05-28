//
//  AppDelegate.m
//  lesson6
//
//  Created by iOS-School-1 on 11.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    FirstViewController *firstVC = [FirstViewController new];
    SecondViewController *secondVC = [SecondViewController new];
    ThirdViewController *thirdVC = [ThirdViewController new];
    //NSArray *viewControllers = @[secondVC, thirdVC];
    
//    UINavigationController *navigationController1 = [UINavigationController new];
//    navigationController1.viewControllers = @[firstVC];
    
    UINavigationController *navigationController2 = [UINavigationController new];
    [navigationController2 setTitle:@"Second Screen"];
    
    navigationController2.viewControllers = @[secondVC];
    
    UINavigationController *navigationController3 = [UINavigationController new];
    [navigationController3 setTitle:@"Third screen"];
    navigationController3.viewControllers = @[thirdVC];
    
    NSArray *navigationControllers = @[firstVC, navigationController2, navigationController3];
    
    
//    UISplitViewController *splitViewController = [UISplitViewController new];
//    splitViewController.viewControllers = viewControllers;
    
    UITabBarController *tabBarController = [UITabBarController new];
    [tabBarController setViewControllers:navigationControllers animated:YES];
    
    window.rootViewController = tabBarController;
//    window.rootViewController = splitViewController;
    
//    window.rootViewController = navigationController;

    
    self.window = window;
    [window makeKeyAndVisible];
    
    return YES;
}

@end
