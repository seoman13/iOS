//
//  CBViewController.m
//  2017-04-25-contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBViewController.h"
#import "CBContactsTableViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation CBViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CBContactsTableViewController *tableViewController = [[CBContactsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:loginButton.imageView.image style:UIBarButtonItemStylePlain target:self action:@selector(goToFBAuthPage)];
    btnItem.tintColor = [UIColor blueColor];
    
    self.navigationItem.rightBarButtonItems = @[btnItem];
    self.viewControllers = @[tableViewController] ;
}

-(void)goToFBAuthPage{
    
}
@end
