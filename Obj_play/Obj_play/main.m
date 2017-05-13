//
//  main.m
//  Obj_play
//
//  Created by Admin on 03.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

// New class - point interface
@interface XYpoint: NSObject

-(void) setX: (int) x;
-(void) setY: (int) y;
-(int) getX;
-(int) getY;

@end

// implementation section
@implementation XYpoint
{
    int X;
    int Y;
}

-(void) setX: (int) x
{
    X = x;
}

-(void) setY: (int) y
{
    Y = y;
}

-(int) getX
{
    return X;
}

-(int) getY
{
    return Y;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        XYpoint *point = [[XYpoint alloc] init];
        
        [point setX: 3];
        [point setY: 6];
        
        NSLog(@"Point (x, y) equals (%i, %i)", [point getX], [point getY]);
        
    return 0;
    }
}

