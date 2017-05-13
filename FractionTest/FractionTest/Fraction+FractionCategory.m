//
//  Fraction+FractionCategory.m
//  FractionTest
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Fraction+FractionCategory.h"

@implementation Fraction (MathOps)

-(Fraction *) add: (Fraction *) f
{
    // To add two fractions:
    // a/b + c/d = ((a*d) + (b*c)) / (b * d)
    Fraction *result = [[Fraction alloc] init];
    result.numerator = (self.numerator * f.denominator) +
    (self.denominator * f.numerator);
    result.denominator = self.denominator * f.denominator;
    [result reduce];
    return result;
}
-(Fraction *) sub: (Fraction *) f
{
    // To sub two fractions:
    // a/b - c/d = ((a*d) - (b*c)) / (b * d)
    Fraction *result = [[Fraction alloc] init];
    result.numerator = (self.numerator * f.denominator) -
    (self.denominator * f.numerator);
    result.denominator = self.denominator * f.denominator;
    [result reduce];
    return result;
}
-(Fraction *) mul: (Fraction *) f
{
    Fraction *result = [[Fraction alloc] init];
    result.numerator = self.numerator * f.numerator;
    result.denominator = self.denominator * f.denominator;
    [result reduce];
    return result;
}
-(Fraction *) div: (Fraction *) f
{
    Fraction *result = [[Fraction alloc] init];
    result.numerator = self.numerator * f.denominator;
    result.denominator = self.denominator * f.numerator;
    [result reduce];
    return result;
}
-(Fraction *) invert{
    Fraction *inverted = [[Fraction alloc] init];
    inverted.numerator = self.denominator;
    inverted.denominator = self.numerator;
    return inverted;
}
@end
