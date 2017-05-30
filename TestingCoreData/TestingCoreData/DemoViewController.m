//
//  DemoViewController.m
//  TestingCoreData
//
//  Created by iOS-School-1 on 30.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "DemoViewController.h"
#import "CoreDataStack.h"
@import CoreData;
#import "Person+CoreDataClass.h"

@interface DemoViewController ()

@property (nonatomic, strong) CoreDataStack *coreDataStack;

@end

@implementation DemoViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.coreDataStack = [CoreDataStack stack];
    }
    
    return self;
}

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [NSUserDefaults standardUserDefaults]
    self.view.backgroundColor = [UIColor greenColor];

    
//    Person *person = (id)[NSEntityDescription entityForName:@"Person" inManagedObjectContext:_coreDataStack.coreDataContext];
    Person *person = (id)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_coreDataStack.coreDataContext];
    person.firstName = @"Vasa";
    person.lastNmae = @"Ivanov";
    person.age = 15;
    [_coreDataStack save];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
