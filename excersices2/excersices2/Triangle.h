//
//  Triangle.h
//  excersices2
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "GraphicObject.h"
@class XYPoint;

@interface Triangle : GraphicObject

@property float side1, side2, side3;

-(XYPoint *) origin;
-(void) setOrigin: (XYPoint *) pt;
-(float) perimeter;

@end
