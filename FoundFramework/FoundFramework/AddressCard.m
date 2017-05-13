//
//  AddressCard.m
//  FoundFramework
//
//  Created by Admin on 07.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "AddressCard.h"

@implementation AddressCard

-(void) setName:(NSString *)name andEmail:(NSString *)email{
    self.name = name;
    self.email = email;
}

-(void) print{
    NSLog (@"====================================");
    NSLog (@"| |");
    NSLog (@"| %-31s |", [self.name UTF8String]);
    NSLog (@"| %-31s |", [self.email UTF8String]);
    NSLog (@"| |");
    NSLog (@"| |");
    NSLog (@"| |");
    NSLog (@"| O O |");
    NSLog (@"====================================");
}

-(BOOL) isEqual: (AddressCard *) theCard{
    if([self.name isEqualToString: theCard.name] && [self.email isEqualToString: theCard.email])
        return YES;
    else
        return NO;
}

-(NSComparisonResult) compareNames: (id) element
{
    return [self.name compare: [element name]];
}
@end
