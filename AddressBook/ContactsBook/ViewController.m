//
//  ViewController.m
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "AddModel.h"
#import "DetailViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

//@property(nonatomic, strong) NSMutableArray *contacts;
@property(nonatomic, copy) NSArray *contacts;
@property(nonatomic, strong) UINavigationController *nav;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AddModel *model = [[AddModel alloc] init];
    self.contacts = [model getContacts];
    
    UITableView *tableContacts = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tableContacts.delegate = self;
    tableContacts.dataSource = self;
    
    
    [self.view addSubview:tableContacts];
    
    [tableContacts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.width.equalTo(self.view.mas_width).with.offset(-20);
//        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(self.view.mas_height);
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contacts count];;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    CustomTableViewCell *cell = [[CustomTableViewCell alloc] init];
    cell.textLabel.text = self.contacts[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    DetailViewController *vc = [DetailViewController new];
    vc.navigationItem.title = @"Additional Information";
    [vc gettContact:self.contacts[indexPath.row]];
    
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Custom UITableViewCell

@end
