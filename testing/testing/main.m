//
//  main.m
//  testing
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Fraction.h"
#import "Fraction2.h"

int main (int argc, char * argv[])
{
    @autoreleasepool {
        Fraction *myFraction = [[Fraction alloc] init];
        
        // set fraction to 1/3
        [myFraction setNumerator: 1];
        [myFraction setDenominator: 3];
        
        // display the fraction
        NSLog (@"The value of myFraction is:");
        
        [myFraction print];
        
        Fraction2 *bFraction = [[Fraction2 alloc] init];
        [bFraction setNominator: 5];
        [bFraction setDenominator:9];
        Fraction2 *cFraction = [Fraction2 new];
        cFraction.nominator = 4;
        cFraction.denominator = 3;
        [bFraction print:YES];
        [cFraction print:YES];
        
        NSLog(@"%i objects were initialized\n", [Fraction2 initCounts]);
        
        
        
    }
    return 0;
}
