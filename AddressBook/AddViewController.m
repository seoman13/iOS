//
//  AddViewController.m
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AddViewController.h"
#import "Masonry/Masonry.h"
#import "AddModel.h"
#import "Contact.h"

@interface AddViewController ()

@property(nonatomic, strong) UILabel *addLabel;
@property(nonatomic, strong) UITextField *addField;
@property(nonatomic, strong) UIButton *addButton;
@property(nonatomic, strong) AddModel *model;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addLabel = [UILabel new];
    self.addLabel.text = @"Add contact";
    
    [self.view addSubview:self.addLabel];
    
    [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.top.equalTo(self.view.mas_top).with.offset(20);
    }];
    
    
    
    self.addField = [[UITextField alloc] init];
    self.addField.borderStyle = UITextBorderStyleRoundedRect;
    self.addField.placeholder = @"Enter contact";
    [self.view addSubview:self.addField];
    
    [self.addField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addLabel.mas_left);
        make.top.equalTo(self.addLabel.mas_bottom).with.offset(10);
        make.width.equalTo(self.view.mas_width).with.offset(-30);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    self.addButton = [UIButton new];
    self.addButton.titleLabel.text = @"Add Contact";
    
    [self.view addSubview:self.addButton];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.self.addField).with.offset(10);
        make.left.equalTo(self.addField);
    }];
    
    self.model = [AddModel new];
    
//    [self.addButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

//-(void)buttonTapped:(UIButton *)button{
//    Contact *contact = [Contact new];
//    [contact.name setString:self.addField.text];
////    [contact.surname setString:self.addField.text];
//    [self.model addContact:contact];
//}


@end
