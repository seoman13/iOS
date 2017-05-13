//
//  main.m
//  excersices2
//
//  Created by Admin on 04.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Complex.h"
#import "Rectangle.h"
#import "Square.h"
#import "XYPoint.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //float c = 2.55;
        //NSLog (@"d = %8.4e", (3.31e-5 + 2.01e-7)/(7.16e-6 + 2.01e-8));
        
        Complex *myVal = [[Complex alloc] init];
        Complex *myVal2 = [[Complex alloc] init];
        
        
        [myVal setReal: 4.27];
        [myVal setImaginary: 5.26];
        
        [myVal2 setReal: 83.5];
        [myVal2 setImaginary: 92.1];
        
        Complex *sum = [myVal add: myVal2];
        
        [sum print];
        
        
        Rectangle *myRect = [[Rectangle alloc] init];
        
        [myRect setWidth: 20];
        [myRect setHeight: 30];
        
        [myRect area];
        
        Rectangle *myRect1 = [[Rectangle alloc] init];
        [myRect1 setWidth: 5 andHeight: 8];
        NSLog (@"Rectangle: w = %f, h = %f", myRect1.width, myRect1.height);
        NSLog (@"Area = %f, Perimeter = %f", [myRect1 area], [myRect1 perimeter]);
        
        
        Square *mySquare = [[Square alloc] init];
        [mySquare setSide: 5];
        NSLog (@"Square s = %f", [mySquare side]);
        NSLog (@"Area = %f, Perimeter = %f",
               [mySquare area], [mySquare perimeter]);
        
        
        Rectangle *myRect3 = [[Rectangle alloc] init];
        XYPoint *myPoint = [[XYPoint alloc] init];
        [myPoint setX: 100 andY: 200];
        [myRect3 setWidth: 5 andHeight: 8];
        myRect3.origin = myPoint;
        NSLog (@"Rectangle w = %f, h = %f", myRect3.width, myRect3.height);
        NSLog (@"Origin at (%f, %f)", myRect3.origin.x, myRect3.origin.y);
        NSLog (@"Area = %f, Perimeter = %f",[myRect3 area], [myRect3 perimeter]);
        
        Rectangle *rc = [[Rectangle alloc] initWithWidth:5.5 andHeight:7];
        NSLog (@"Rectangle w = %f, h = %f", rc.width, rc.height);
    
    }
    return 0;
}
