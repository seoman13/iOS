//
//  Fraction+Comparison.h
//  FractionTest
//
//  Created by Admin on 06.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Fraction.h"

@interface Fraction (Comparison)
-(BOOL) isEqualTo: (Fraction *) f;
-(NSComparisonResult) compareToFraction: (Fraction *) f;
@end
