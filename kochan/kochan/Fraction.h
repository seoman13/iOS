//
//  Fraction.h
//  kochan
//
//  Created by Admin on 11.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fraction : NSObject

@property int numerator, denominator;
-(void) print;
-(void) setTo: (int) n over: (int) d;
-(Fraction *) add: (Fraction *) f;
-(Fraction *) subtract: (Fraction *) f;
-(Fraction *) multiply: (Fraction *) f;
-(Fraction *) divide: (Fraction *) f;
-(void) reduce;
-(double) convertToNum;
-(NSString *) convertToString;
@end
