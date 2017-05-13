//
//  Complex.h
//  excersices2
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Complex: NSObject
@property double real, imaginary;
-(void) print;
-(Complex *) add: (Complex *) c;
-(void) setReal: (double) a andImaginary: (double) b;
@end
