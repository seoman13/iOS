//
//  Square.h
//  excersices2
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Rectangle.h"
/*
@interface Square : Rectangle

-(void) setSide: (float) s;
-(float) side;
-(instancetype) initWithSide: (float) side;

@end
*/
@interface Square: NSObject

-(instancetype) initWithSide: (int) s;
-(void) setSide: (int) s;
-(int) side;
-(int) area;
-(int) perimeter;

@end
