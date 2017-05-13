//
//  Fraction.m
//  kochan
//
//  Created by Admin on 11.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

@synthesize numerator, denominator;
-(void) setTo: (int) n over: (int) d
{
    numerator = n;
    denominator = d;
}
-(void) print
{
    NSLog (@"%i/%i", numerator, denominator);
}
-(double) convertToNum
{
    if (denominator != 0)
        return (double) numerator / denominator;
    else
        return NAN;
}
-(NSString *) convertToString
{
    if (numerator == denominator)
        if (numerator == 0)
            return @"0";
        else
            return @"1";
        else if (denominator == 1)
            return [NSString stringWithFormat: @"%i", numerator];
        else
            return [NSString stringWithFormat: @"%i/%i",
                    numerator, denominator];
}
// add a Fraction to the receiver
-(Fraction *) add: (Fraction *) f
{
    // To add two fractions:
    // a/b + c/d = ((a*d) + (b*c)) / (b * d)
    // result will store the result of the addition
    Fraction *result = [[Fraction alloc] init];
    result.numerator = numerator * f.denominator +
    denominator * f.numerator;
    result.denominator = denominator * f.denominator;
    [result reduce];
    return result;
}
-(Fraction *) subtract: (Fraction *) f
{
    // To sub two fractions:
    // a/b - c/d = ((a*d) - (b*c)) / (b * d)
    Fraction *result = [[Fraction alloc] init];
    result.numerator = numerator * f.denominator - denominator * f.numerator;
    result.denominator = denominator * f.denominator;
    [result reduce];
    return result;
}
-(Fraction *) multiply: (Fraction *) f
{
    Fraction *result = [[Fraction alloc] init];
    result.numerator = numerator * f.numerator;
    result.denominator = denominator * f.denominator;
    [result reduce];
    return result;
}
-(Fraction *) divide: (Fraction *) f
{
    Fraction *result = [[Fraction alloc] init];
    result.numerator = numerator * f.denominator;
    result.denominator = denominator * f.numerator;
    [result reduce];
    return result;
}
- (void) reduce
{
    int u = numerator;
    int v = denominator;
    int temp;
    if (u == 0)
        return;
    else if (u <0)
        u = -u;
    while (v != 0) {
        temp = u % v;
        u = v;
        v = temp;
    }
    numerator /= u;
    denominator /= u;
}
@end
