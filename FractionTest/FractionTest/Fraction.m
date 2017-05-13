//
//  Fraction.m
//  FractionTest
//
//  Created by Admin on 04.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Fraction.h"
#import "Fraction+Comparison.h"

static int gAddCount;

//@interface Fraction ()
//-(BOOL) isEqualTo: (Fraction *) f;
//-(BOOL) isLessThanOrEqualTo: (Fraction *) f;;
//-(BOOL) isLessThan: (Fraction *) f;;
//-(BOOL) isGreaterThanOrEqualTo: (Fraction *) f;;
//-(BOOL) isGreaterThan: (Fraction *) f;;
//-(BOOL) isNotEqualTo: (Fraction *) f;;
//@end

@implementation Fraction

@synthesize numerator, denominator;

-(void) print: (BOOL) b
{
    if (b)
    NSLog (@"%i/%i", numerator, denominator);
}

-(double) convertToNum
{
    if (denominator != 0)
        return (double) numerator / denominator;
    else
        return NAN;
}

-(void) setTo: (int) n over: (int) d
{
    numerator = n;
    denominator = d;
}

+(void) showCount{
    NSLog(@"Add was invoked %i times\n", gAddCount);
}

// add a Fraction to the receiver
/*-(Fraction *) add: (Fraction *) f
{
    gAddCount++;
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
*/
// Subtract argument from receiver
-(Fraction *) subtract: (Fraction *) f
{
    Fraction *result = [[Fraction alloc] init];
    result.numerator = numerator * f.denominator -
    denominator * f.numerator;
    result.denominator = denominator * f.denominator;
    [result reduce];
    return result;
}
// Multiply receiver by argument
-(Fraction *) multiply: (Fraction *) f
{
    Fraction *result = [[Fraction alloc] init];
    result.numerator = numerator * f.numerator;
    result.denominator = denominator * f.denominator;
    [result reduce];
    return result;
}
// Divide receiver by argument
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
    while (v != 0) {
        temp = u % v;
        u = v;
        v = temp;
    }
    numerator /= u;
    denominator /= u;
}

-(NSString *)description{
    return [NSString stringWithFormat: @"%i/%i", self.numerator, self.denominator ];
}

@end
