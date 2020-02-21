//
//  DetailViewController.m
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property(nonatomic, copy) Contact *contact;
@property(nonatomic, strong) UILabel *label;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

-(void)gettContact:(Contact *)contact{
    self.contact = contact;
}


@end
