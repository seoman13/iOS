//
//  AddressBook.m
//  FoundFramework
//
//  Created by Admin on 07.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "AddressBook.h"
#import "AddressCard.h"

@implementation AddressBook

-(instancetype) initWithName: (NSString *) name{
    self = [super init];
    if(self){
        _bookName = [[NSString alloc] initWithString:name];
        _book = [NSMutableArray array];
    }
    return self;
}

-(instancetype) init{
    return[self initWithName: @"NoName"];
}

-(void) addCard: (AddressCard *) theCard{
    [self.book addObject: theCard];
}
-(NSUInteger) entries{
    return [self.book count];
}
-(void) list{
    NSLog (@"======== Contents of: %@ =========", self.bookName);
    /*for ( AddressCard *theCard in self.book )
        NSLog (@"%-20s %-32s", [theCard.name UTF8String],
               [theCard.email UTF8String]);*/
    [self.book enumerateObjectsUsingBlock:^(AddressCard *theCard, NSUInteger idx, BOOL *stop) {
        NSLog(@"%-20s %-32s", [theCard.name UTF8String],
               [theCard.email UTF8String]);
        NSLog(@"==================================================");
    }];
}

-(AddressCard *) lookup: (NSString *) theName
{
    for (AddressCard *nextCard in self.book )
        if ( [nextCard.name localizedCaseInsensitiveCompare: theName] == YES )
            return nextCard;
    return nil;
}

-(void) removeCard: (AddressCard *) theCard{
    for (AddressCard *nextCard in self.book){
        if ((nextCard.name == theCard.name) == YES && (nextCard.email == theCard.email) == YES){
            [self.book removeObject: nextCard];
        }
    }
}

-(void) sort
{
    [self.book sortUsingSelector: @selector(compareNames:)];
}

-(void) aSort{
    [self.book sortUsingComparator:^NSComparisonResult(AddressCard *card1, AddressCard *card2) {
        return [card1.name compare:card2.name];
    }];
}
@end
