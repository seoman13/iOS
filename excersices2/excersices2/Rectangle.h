//
//  Rectangle.h
//  excersices2
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYPoint;

@interface Rectangle: NSObject

@property float width, height;

-(id) initWithWidth: (float) w andHeight: (float) h;
-(XYPoint *) origin;
-(void) setOrigin: (XYPoint *) pt;
-(float) area;
-(float) perimeter;
-(void) setWidth: (float) w andHeight: (float) h;
-(void) translate: (XYPoint *) pt;
-(BOOL) containsPoint: (XYPoint *) aPoint;
@end
