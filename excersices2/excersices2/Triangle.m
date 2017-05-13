//
//  Triangle.m
//  excersices2
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Triangle.h"
#import "XYPoint.h"

@implementation Triangle
{
    XYPoint *origin;
}
@synthesize side1, side2, side3;

-(float) perimeter{
    return side1 + side2 + side3;
}

-(void) setside1: (float) s1 side2:(float) s2 side3: (float) s3{
    side1 = s1;
    side2 = s2;
    side3 = s3;
}

-(void) setOrigin: (XYPoint *) pt
{
    if (! origin)
        origin = [[XYPoint alloc] init];
    origin.x = pt.x;
    origin.y = pt.y;
}
-(XYPoint *) origin
{
    XYPoint *or_cp = [[XYPoint alloc] init];
    or_cp.x = origin.x;
    or_cp.y = origin.y;
    return or_cp;
}
-(void) translate:(XYPoint *)pt{
    self.origin.x += pt.x;
    self.origin.y += pt.y;
}
@end
