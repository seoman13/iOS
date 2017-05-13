//
//  Circle.h
//  excersices2
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "GraphicObject.h"
@class XYPoint;

@interface Circle : GraphicObject

@property float radius;

-(void) setCenter: (XYPoint *) c;
-(XYPoint *) center;
-(float) circum;
-(float) area;
-(float) radius;
-(float) diameter;

@end
