//
//  Square.m
//  excersices2
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Square.h"
#import "Rectangle.h"
/*
@implementation Square

-(void) setSide:(float)s{
    [self setWidth: s andHeight: s];
}

-(float) side{
    return self.width;
}

-(id) initWithSide: (float) side{
    self = [self init];
    if(self){
        [self setSide: side];
    }
    return self;
}
@end
*/

@implementation Square
{
    Rectangle *rect;
}
-(instancetype) initWithSide: (int) s{
    self = [super init];
    if (self){
        self.side = s;
        rect = [[Rectangle alloc] initWithWidth:s andHeight:s];
    }
    return self;
}
-(void) setSide: (int) s{
    self.side = s;
}
-(int) side{
    return self.side;
}
-(int) area{
    return [rect area];
}
-(int) perimeter{
    return [rect perimeter];
}
@end
