//
//  Fraction.h
//  FractionTest
//
//  Created by Admin on 04.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject

@property int numerator, denominator;
-(void) print: (BOOL) b;
-(void) setTo: (int) n over: (int) d;
-(double) convertToNum;
//-(Fraction *) add: (Fraction *) f;
- (void) reduce;
// Subtract argument from receiver
-(Fraction *) subtract: (Fraction *) f;
// Multiply receiver by argument
-(Fraction *) multiply: (Fraction *) f;
// Divide receiver by argument
-(Fraction *) divide: (Fraction *) f;
+(void) showCount;
-(NSString *)description;
@end
