//
//  AddressBook.h
//  FoundFramework
//
//  Created by Admin on 07.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AddressCard;

@interface AddressBook : NSObject

@property(nonatomic, copy) NSString *bookName;
@property(nonatomic, strong) NSMutableArray *book;

-(instancetype) initWithName: (NSString *) name;
-(void) addCard: (AddressCard *) theCard;
-(NSUInteger) entries;
-(void) list;
-(AddressCard *) lookup: (NSString *) theName;
-(void) sort;
-(void) removeCard: (AddressCard *) theCard;

-(void) aSort;

@end
