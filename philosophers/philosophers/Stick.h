//
//  Stick.h
//  philosophers
//
//  Created by iOS-School-1 on 13.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stick : NSObject

@property (nonatomic) NSString *number;

- (void)takeStick;
- (void)putDownStick;

@end
