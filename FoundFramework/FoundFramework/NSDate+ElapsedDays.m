//
//  NSDate+ElapsedDays.m
//  FoundFramework
//
//  Created by Admin on 07.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "NSDate+ElapsedDays.h"

@implementation NSDate (ElapsedDays)
-(unsigned long) elapsedDays: (NSDate *) theDate{
    return [self timeIntervalSinceDate:theDate];
}
@end
