//
//  Calculator.h
//  Calculator
//
//  Created by Admin on 06.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator: NSObject

// accumulator methods
-(void) setAccumulator: (double) value;
-(void) clear;
-(double) accumulator;

// arithmetic methods
-(double) add: (double) value;
-(double) subtract: (double) value;
-(double) multiply: (double) value;
-(double) divide: (double) value;

-(double) changeSign; // change sign of accumulator
-(double) reciprocal; // 1/accumulator
-(double) xSquared; // accumulator squared

-(double) memoryClear; // clear memory
-(double) memoryStore; // set memory to accumulator
-(double) memoryRecall; // set accumulator to memory
-(double) memoryAdd: (double) value; // add value into memory
-(double) memorySubtract: (double) value; // subtract value from memory

@end
