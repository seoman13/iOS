//
//  main.m
//  Blocks
//
//  Created by iOS-School-1 on 15.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockTestClass : NSObject

-(void)testMemory;

@end

@interface BlockTestClass(){
    NSString *_str2;
}

@property(nonatomic, copy) NSString *str;
@property(nonatomic, copy) void (^test)(void);

@end

@implementation BlockTestClass

-(instancetype)init {
    self = [super init];
    if(self){
        _str  = @"Hello World!";
        _str2 = @"Hello world!";
    }
    return self;
}

-(void)testMemory {
//    __weak typeof(self) weakSelf = self;
//    self.test = ^void(void) {
//        __strong typeof(self) strongSelf = weakSelf;
//        NSLog(@"%@", strongSelf.str); /////retain cycle if self instead of weakSelf
//    };
//    self.test();
    __weak typeof(self) weakSelf = self;
    self.test = ^void(void) {
//        NSLog(@"%@", _str2);//when giving ivar we implicitly give self, thus retain cycle
        __strong typeof(self) strongSelf = weakSelf;
        NSLog(@"%@", strongSelf ->_str2);
    };
    
    self.test();
}


@end
//void f(int a, int (^inc)(void)){
//    NSLog(@"%@", @(a + inc()));
//}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BlockTestClass *test = [BlockTestClass new];
        [test testMemory];
        
        
        NSArray *arr = @[@(1), @(2), @(3), @(4), @(5)];
        
        
        
        [arr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (3 == [obj intValue]){
                NSLog(@"%@", @(idx));
                //stop = YES;
            }
        }];
        
//        __block int a = 10;
//        int(^inc)(void) = ^int(void){
//            //NSLog(@"%@", @(a));
//            return ++a;                           // stack block
//        };
////        a += 10;
////        f(2, inc);
//        [inc copy];                               // copying to heap, nsmalloc block
        
        
//        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"Hello World!");
//            });
//        });
        
    }
    return 0;
}
