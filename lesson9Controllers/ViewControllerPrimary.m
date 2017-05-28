//
//  ViewControllerPrimary.m
//  lesson9
//
//  Created by Admin on 20/04/2017.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ViewControllerPrimary.h"

@interface ViewControllerPrimary ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *monsters;

@end

@implementation ViewControllerPrimary

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self createMonsters];
    [self.view addSubview: self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    UIViewController *vc = [UIViewController new];
//    
//    
//}

-(instancetype)init{
    self = [super init];
    if(self){
        [self createMonsters];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.monsters count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.monsters[indexPath.row];
    return cell;
}

-(void)createMonsters{
    self.monsters = @[@"Lohness Monster",
             @"Scary witch",
             @"Cute pitbull",
             @"Deathly rabbit"];
    //NSLog(@"%lu", (unsigned long)[self.monsters count]);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
