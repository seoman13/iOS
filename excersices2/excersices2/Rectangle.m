//
//  Rectangle.m
//  excersices2
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Rectangle.h"
#import "XYPoint.h"
//@class XYPoint;

@implementation Rectangle
{
    XYPoint *origin;
}

@synthesize width, height;

-(id) initWithWidth: (float) w andHeight: (float) h{
    self = [self init];
    
    if(self){
        [self setWidth: w andHeight: h];
    }
    return self;
}

-(float) area{
    return width * height;
}

-(float) perimeter{
    return 2 * (width + height);
}

-(void) setWidth: (float) w andHeight: (float) h{
    width = w;
    height = h;
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

-(BOOL) containsPoint: (XYPoint *) aPoint{
    if(aPoint.x >= origin.x && aPoint.x <= origin.x + width && aPoint.y >= origin.y && aPoint.y <= origin.y + height)
        return YES;
    else
        return NO;
}
@end
