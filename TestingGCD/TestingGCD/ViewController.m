//
//  ViewController.m
//  TestingGCD
//
//  Created by iOS-School-1 on 16.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


//singleton
+ (instancetype)sharedInstance {
    static ViewController *_sharedInst = nil;
    
    static dispatch_once_t once_Token;
    dispatch_once(&once_Token, ^{
        _sharedInst = [super init];
    });
    return _sharedInst;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    dispatch_queue_t
//    dispatch_get_main_queue()
//    dispatch_get_current_queue() // deprecated
    
    dispatch_queue_t queue = dispatch_queue_create("ru.sergik.demo-queue", 0);//DISPATCH_QUEUE_CONCURRENT,
    
    dispatch_semaphore
//    dispatch_queue_attr_t
    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        [self someMethod];                             // tak nelza delat
//    });
    
   // dispatch_apply(<#size_t iterations#>, <#dispatch_queue_t  _Nonnull queue#>, <#^(size_t)block#>) //
    

    
    
    dispatch_block_t block = ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"/n sync %d", i);
        }
    };
    
    
    
    //dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC))
    
    //dispatch_semaphore_t sem = dispatch_semaphore_signal(<#dispatch_semaphore_t  _Nonnull dsema#>)
    
    
    
    //dispatch_queue_t queue = dispatch_queue_create("", 0);
    
    
    
//
//    
//    
////    dispatch_async(queue,block);
//    dispatch_async(dispatch_get_main_queue(),block);
//    
//    dispatch_block_cancel(block);
//    
//    dispatch_async(queue, ^{
//        for (int i = 0; i < 10; i++) {
//            NSLog(@"/n sync 2 %d", i);
//        }
//    });
//    
//    for (int i = 0; i < 10; i++) {
//        NSLog(@"/n main %d", i);
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)someMethod {
    
}
@end
