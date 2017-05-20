//
//  DemoViewController.m
//  TestingNSOperation
//
//  Created by iOS-School-1 on 20.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "DemoViewController.h"
#import "Operation.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.qualityOfService = NSQualityOfServiceUserInitiated;
//    queue.maxConcurrentOperationCount = 1;
    
//    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(someMethod:) object:@"invocationOperation"];
    
//    [self someMethod:@""];
//    
//    [self performSelector:@selector(someMethod:) withObject:nil]; // analogous to before, but bad for ARC, never use, except invocation operation
    
//    [queue addOperation:invocationOperation];
//    
//    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
////        sleep(1);
//        [self someMethod:@"blockOperation"];
//    }];
    
//    [queue addOperation:blockOperation];
    
//    NSOperation *operation = [NSOperation new];
//    operation.completionBlock = ^{
//        [self someMethod:@"operation"];
//    };
//    [operation addDependency:invocationOperation];
//    [queue addOperation:operation];
    
//    [blockOperation addDependency:operation];
    
//    NSBlockOperation *blockOp2 = [NSBlockOperation blockOperationWithBlock:^{
////        sleep(2);
//        NSLog(@"blockOp2");
//    }];
//    [invocationOperation addDependency:blockOp2];
//    [invocationOperation addDependency:operation];
//    [mainQueue addOperation:blockOp2];
    
//    Operation *operation = [Operation new];
//    operation.str = @"Operation";
////    [operation start];
//    [queue addOperation:operation];

    
    Operation *operation = [Operation new];
    operation.str = @"Operation";
    operation.queuePriority = NSOperationQueuePriorityLow;
    [queue addOperation:operation];
    
    
    Operation *operation2 = [Operation new];
    operation2.str = @"Operation2";
    [queue addOperation:operation2];
    
    
    Operation *operation3 = [Operation new];
    operation3.str = @"Operatio3";
    operation3.queuePriority = NSOperationQueuePriorityNormal;
    [queue addOperation:operation3];
    
    
    Operation *operation4 = [Operation new];
    operation4.str = @"Operation4";
    [queue addOperation:operation4];
    
    
    Operation *operation5 = [Operation new];
    operation5.str = @"Operation5";
    operation5.queuePriority = NSOperationQueuePriorityVeryHigh;
    [queue addOperation:operation5];
    
    
//    [mainQueue addOperationWithBlock:^{
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)someMethod:(NSString*)str {
    NSLog(@"%@", [NSThread currentThread]);
    NSLog(@"\n %@", str);
}
@end
