//
//  Fraction+FractionCategory.h
//  FractionTest
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Fraction.h"

@interface Fraction (MathOps)

-(Fraction *) add: (Fraction *) f;
-(Fraction *) mul: (Fraction *) f;
-(Fraction *) sub: (Fraction *) f;
-(Fraction *) div: (Fraction *) f;
-(Fraction *) invert;
@end
