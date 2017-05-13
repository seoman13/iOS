//
//  Fraction.m
//  testing
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Fraction.h"
@implementation Fraction
{
    int numerator;
    int denominator;
}
-(void) print
{
    NSLog (@"%i/%i", numerator, denominator);
}
-(void) setNumerator: (int) n
{
    numerator = n;
}
-(void) setDenominator: (int) d
{
    denominator = d;
}
-(int) numerator
{
    return numerator;
}
-(int) denominator
{
    return denominator;
}
-(double) convertToNum
{
    if (denominator != 0)
        return (double) numerator / denominator;
    else
        return NAN;
}
@end
