//
//  main.m
//  Calculator
//
//  Created by Admin on 04.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

// Implement a Calculator class
#import <Foundation/Foundation.h>
#import "Calculator.h"
#import "Calculator+Trig.h"

int main (int argc, char * argv[])
{
    @autoreleasepool {
        Calculator *deskCalc = [[Calculator alloc] init];
        [deskCalc setAccumulator: 100.0];
        [deskCalc add: 200.];
        [deskCalc divide: 15.0];
        [deskCalc subtract: 10.0];
        [deskCalc multiply: 5];
        NSLog (@"The result is %g\n", [deskCalc accumulator]);
        [deskCalc xSquared];
        NSLog (@"Squared result is %g\n", [deskCalc accumulator]);
        [deskCalc reciprocal];
        NSLog (@"Reciprocal result is %g\n", [deskCalc accumulator]);
    }
    return 0;
}
