//
//  Fraction2.m
//  testing
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Fraction2.h"

static int fractionCounts = 0;

@implementation Fraction2

@synthesize nominator = _nominator, denominator = _denominator;

// without synthesize compiler will generate _nominator and _denominator with underscore as its first letter
-(id) init
{
    fractionCounts++;
    return self;
}
+(int) initCounts
{
    return fractionCounts;
}

-(void) print: (BOOL) b
{
    if (b == YES){
        if (_nominator > _denominator){
            NSLog(@"Fraction is %i %i/%i\n", _nominator/_denominator, _nominator % _denominator, _denominator);
        }
        else
            NSLog(@"Fraction is %i/%i\n", _nominator, _denominator);
    }
    
}

-(void) setTo:(int)n over:(int)d
{
    _nominator = n;
    _denominator = d;
}

-(double) convertToNum
{
    if (_denominator != 0)
        return (double) _nominator/_denominator;
    else
        return NAN;
}

// add a Fraction to the receiver
- (void) add: (Fraction2 *) f
{
    // To add two fractions:
    // a/b + c/d = ((a*d) + (b*c)) / (b * d)
    _nominator = _nominator * f.denominator + _denominator * f.nominator;
    _denominator = _denominator * f.denominator;
    
    [self reduce];
}

- (void) reduce
{
    int u = _nominator;
    int v = _denominator;
    int temp;
    while (v != 0) {
        temp = u % v;
        u = v;
        v = temp;
    }
    _nominator /= u;
    _denominator /= u;
}

-(Fraction2 *) add1: (Fraction2 *) f
{
    // To add two fractions:
    // a/b + c/d = ((a*d) + (b*c)) / (b * d)
    // result will store the result of the addition
    Fraction2 *result = [[Fraction2 alloc] init];
    result.nominator = _nominator * f.denominator +
    _denominator * f.nominator;
    result.denominator = _denominator * f.denominator;
    [result reduce];
    return result;
}

// Subtract argument from receiver
-(Fraction2 *) subtract: (Fraction2 *) f
{
    Fraction2 *result = [[Fraction2 alloc] init];
    result.nominator = _nominator * f.denominator -
    _denominator * f.nominator;
    result.denominator = _denominator * f.denominator;
    [result reduce];
    return result;
}
// Multiply receiver by argument
-(Fraction2 *) multiply: (Fraction2 *) f
{
    Fraction2 *result = [[Fraction2 alloc] init];
    result.nominator = _nominator * f.nominator;
    result.denominator = _denominator * f.denominator;
    [result reduce];
    return result;
}
// Divide receiver by argument
-(Fraction2 *) divide: (Fraction2 *) f
{
    Fraction2 *result = [[Fraction2 alloc] init];
    result.nominator = _nominator * f.denominator;
    result.denominator = _denominator * f.nominator;
    [result reduce];
    return result;
}
@end
