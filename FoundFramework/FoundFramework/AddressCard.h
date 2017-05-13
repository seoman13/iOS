//
//  AddressCard.h
//  FoundFramework
//
//  Created by Admin on 07.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressCard : NSObject

@property(nonatomic, copy) NSString *name, *email;

-(void) print;
-(void) setName:(NSString *)name andEmail:(NSString *)email;
-(BOOL) isEqual: (AddressCard *) theCard;
-(NSComparisonResult) compareNames: (id) element;
@end
