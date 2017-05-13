//
//  Fraction2.h
//  testing
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction2 : NSObject

@property int nominator, denominator;

+(int) initCounts;
-(void) print: (BOOL) b;
-(void) setTo: (int) n over: (int) d;
-(double) convertToNum;
-(void) add: (Fraction2 *) f;
-(Fraction2 *) add1: (Fraction2 *) f;
-(void) reduce;

// Subtract argument from receiver
-(Fraction2 *) subtract: (Fraction2 *) f;

// Multiply receiver by argument
-(Fraction2 *) multiply: (Fraction2 *) f;

// Divide receiver by argument
-(Fraction2 *) divide: (Fraction2 *) f;

@end
