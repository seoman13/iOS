//
//  ViewController.m
//  TestingMock
//
//  Created by iOS-School-1 on 15.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Setup SearchBar and its Delegate
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"Mumbo Jumbo";
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    self.navigationController.navigationBar.translucent = NO;
    
    // Setup TableView with its Delegate and DataSource
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmiss)];
    [self.view addGestureRecognizer:tapRecognizer];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void)dissmiss {
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
}

@end
