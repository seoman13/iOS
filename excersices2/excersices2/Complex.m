//
//  Complex.m
//  excersices2
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Complex.h"

@implementation Complex

@synthesize real, imaginary;

-(void) print
{
    NSLog (@" %g + %gi ", real, imaginary);
}
-(void) setReal: (double) a andImaginary: (double) b
{
    real = a;
    imaginary = b;
}
-(Complex *) add: (Complex *) f
{
    Complex *result = [[Complex alloc] init];
    result.real = real + f.real;
    result.imaginary = imaginary + f.imaginary;
    return result;
}
@end
