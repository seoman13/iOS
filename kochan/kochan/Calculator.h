//
//  Calculator.h
//  kochan
//
//  Created by Admin on 11.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fraction.h"

@interface Calculator : NSObject
@property (strong, nonatomic) Fraction *operand1;
@property (strong, nonatomic) Fraction *operand2;
@property (strong, nonatomic) Fraction *accumulator;
-(Fraction *) performOperation: (char) op;
-(void) clear;
@end
