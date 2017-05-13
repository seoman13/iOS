//
//  main.m
//  FractionTest
//
//  Created by Admin on 04.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Fraction.h"
#import "Fraction+FractionCategory.h"
#import "Fraction+Comparison.h"

int main (int argc, char * argv[])
{
    @autoreleasepool {
        Fraction *a = [[Fraction alloc] init];
        Fraction *b = [[Fraction alloc] init];
        Fraction *result;
        [a setTo: 8 over: 9];
        [b setTo: 2 over: 5];
        [a print: YES]; NSLog (@" +"); [b print: YES]; NSLog (@"-----");
        result = [a add: b];
        [result print: YES];
        NSLog (@"\n");
        [a print: YES]; NSLog (@" -"); [b print: YES]; NSLog (@"-----");
        result = [a sub: b];
        [result print: YES];
        NSLog (@"\n");
        [a print: YES]; NSLog (@" *"); [b print: YES]; NSLog (@"-----");
        result = [a mul: b];
        [result print: YES];
        NSLog (@"\n");
        [a print: YES]; NSLog (@" /"); [b print: YES]; NSLog (@"-----");
        result = [a div: b];
        [result print: YES];
        NSLog (@"\n");
        
        NSArray *arr = [NSArray arrayWithObjects:a, b, result, nil];
        
        NSLog(@"Array: %@", arr);
        
//        for(int i = 0; i < arr.count; i++){
//            NSLog(@"%@", arr[i]);
//        }
//        
//        for (NSString *el in arr){
//            NSLog(@"%@", el);
//        }
//        
//        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
//            NSLog(@"%@", obj);
//        }];
        
        
        NSMutableArray *arr1 = [NSMutableArray array];
        [arr1 addObject:a];
        [arr1 addObject:b];
        [arr1 addObject:result];
        
        NSArray *sortedArray = [arr1 sortedArrayUsingSelector:@selector(compareToFraction:)];
        
        NSLog(@"%@", sortedArray);
    }
    return 0;
}
