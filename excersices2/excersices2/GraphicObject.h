//
//  GraphicObject.h
//  excersices2
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphicObject : NSObject
@property int fillColor, lineColor; // 32-bit color / 32-bit line color
@property BOOL filled; // Is the object filled?
@end
