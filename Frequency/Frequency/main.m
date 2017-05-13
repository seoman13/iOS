//
//  main.m
//  Frequency
//
//  Created by Admin on 10.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *arr = [[NSArray alloc] initWithObjects:@(0), @(1), @(3), @(4), @(5), @(4),@(7),@(9), @(1), @(7),@(6), nil];
        
        NSCountedSet *set = [[NSCountedSet alloc] initWithArray:arr];
        
//        for(id obj in set)
//            NSLog(@"%@ - %lu", obj, (unsigned long)[set countForObject:obj]);
        NSEnumerator *enumerator = [set objectEnumerator];
        NSLog(@"%@", enumerator);
        id element;
        while(element = [enumerator nextObject]){
            NSLog(@"%@ - %lu", element, (unsigned long) [set countForObject:element]);
        }
        

    }
    return 0;
}
