//
//  SecondViewController.m
//  lesson6
//
//  Created by iOS-School-1 on 11.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"

@interface SecondViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy) NSArray *animals;
@property(nonatomic, strong)NSTimer *timer;
@end

@implementation SecondViewController{
    int flag;
}

-(instancetype)init{
    self = [super init];
    if(self){
        self.tabBarItem.title = @"SecondVC";
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -6);
        //self.navigationItem.title = @"Second screen";
        flag = 0;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton *btn = [UIButton new];
//    CGRect bounds = self.view.bounds;
//    btn.frame = CGRectMake(bounds.size.width / 2 - 50, bounds.size.height / 2 - 20, 100, 40);
//    btn.backgroundColor = UIColor.redColor;
//    btn.tag = _buttonTag;
//    [btn setTitle:@"Go" forState:UIControlStateNormal];
//    [btn setTitleColor:UIColor.yellowColor forState:UIControlStateHighlighted];
//    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//
//    self.view.backgroundColor = UIColor.greenColor;
//    self.tabBarItem.title = @"SecondVC";
    
    self.tableView = [UITableView new];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self createModel];
    [self.view addSubview:self.tableView];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer *
                                                                                 _Nonnull timer){
                                                                                self.animals = [self getMEat];
        [self.timer invalidate];
        [self.tableView reloadData];}];
}
//__strong typeof(self) strongSelf = weakSelf; strongSelf.animals = [strongSelf getMeat]; [strongSelf.tableView reloadData];

-(NSArray *)getMEat{
    return @[@"Cat",
             @"Dog"];
}

-(void)createModel{
    self.animals = @[
                   @"Cat",
                   @"Dog",
                   @"Pig",
                   @"Fish",
                   @"Bird"
                   ];
}
#pragma mark - UITableViewDataDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.animals count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.animals[indexPath.row];
    
    return cell;
}

#pragma mark - UIViewTableDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = UIColor.redColor;
    vc.navigationItem.title = [NSString stringWithFormat:@"%ld", indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) buttonClick:(UIButton *)button{
    if(button.tag == 0){
        SecondViewController *vc = [SecondViewController new];
        vc.buttonTag = 1;
        [self.navigationController pushViewController:vc animated:YES];
        button.tag = 1;
    }
    else{
        self.buttonTag = 0;
        button.tag = 0;
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
