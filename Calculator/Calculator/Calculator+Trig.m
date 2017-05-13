//
//  Calculator+Trig.m
//  Calculator
//
//  Created by Admin on 06.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculator+Trig.h"

@implementation Calculator (Trig)
-(double) sin{
    return sin(self.accumulator);
}
-(double) cos{
    return cos(self.accumulator);
}
-(double) tan{
    return tan(self.accumulator);
}
@end
