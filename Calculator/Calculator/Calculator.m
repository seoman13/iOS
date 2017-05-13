//
//  Calculator.m
//  Calculator
//
//  Created by Admin on 06.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator
{
    double memory;
    double accumulator;
}

-(void) setAccumulator: (double) value
{
    accumulator = value;
}

-(void) clear
{
    accumulator = 0;
}
-(double) accumulator
{
    return accumulator;
}
-(double) add: (double) value
{
    accumulator += value;
    return accumulator;
}
-(double) subtract: (double) value
{
    accumulator -= value;
    return accumulator;
}
-(double) multiply: (double) value
{
    accumulator *= value;
    return accumulator;
}
-(double) divide: (double) value
{
    accumulator /= value;
    return accumulator;
}

-(double) changeSign
{
    accumulator = -accumulator;
    return accumulator;
}
-(double) reciprocal
{
    accumulator = 1/accumulator;
    return accumulator;
}
-(double) xSquared
{
    accumulator = accumulator*accumulator;
    return accumulator;
}

-(double) memoryClear
{
    memory = 0;
    return memory;
}
-(double) memoryStore{
    memory = accumulator;
    return memory;
}
-(double) memoryRecall
{
    accumulator = memory;
    return accumulator;
}
-(double) memoryAdd: (double) value
{
    memory += value;
    return memory;
}
-(double) memorySubtract: (double) value
{
    memory -= value;
    return memory;
}

@end
