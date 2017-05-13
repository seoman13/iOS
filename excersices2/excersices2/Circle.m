//
//  Circle.m
//  excersices2
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Circle.h"
#import "XYPoint.h"

@implementation Circle
{
    XYPoint *center;
}
-(void) setCenter:(XYPoint *)c{
    center = [[XYPoint alloc] init];
    center.x = c.x;
    center.y = c.y;
}

-(XYPoint *) center{
    XYPoint *cp = [[XYPoint alloc] init];
    cp.x = center.x;
    cp.y = center.y;
    return cp;
}
-(float) circum{
    return 2*3.1415*self.radius;
}
-(float) area{
    return 3.1415 * self.radius * self.radius;
}
-(float) diameter{
    return self.radius * 2;
}


@end
