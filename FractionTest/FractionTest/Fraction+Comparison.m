//
//  Fraction+Comparison.m
//  FractionTest
//
//  Created by Admin on 06.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Fraction+Comparison.h"

@implementation Fraction (Comparison)
-(BOOL) isEqualTo: (Fraction *) f{
    Fraction *f1 = [[Fraction alloc] init];
    Fraction *f2 = [[Fraction alloc] init];
    f1.denominator = self.denominator;
    f1.numerator = self.numerator;
    f2.denominator = f.denominator;
    f2.numerator = f.numerator;
    
    [f1 reduce];
    [f2 reduce];
    
    if (f1.numerator == f2.numerator && f1.denominator == f2.denominator)
        return YES;
    return NO;
}
-(NSComparisonResult) compareToFraction: (Fraction *) f{
    Fraction *f1 = [[Fraction alloc] init];
    Fraction *f2 = [[Fraction alloc] init];
    f1.denominator = self.denominator;
    f1.numerator = self.numerator;
    f2.denominator = f.denominator;
    f2.numerator = f.numerator;
    
    [f1 reduce];
    [f2 reduce];
    
    double dec1 = (double) f1.numerator/f1.denominator;
    double dec2 = (double) f2.numerator/f2.denominator;
    
    if (f1.numerator == f2.numerator && f1.denominator == f2.denominator)
        return NSOrderedSame;
    else if (dec1 > dec2)
        return NSOrderedDescending;
    return NSOrderedAscending;
}
@end
