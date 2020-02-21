//
//  ContactList.m
//  ContactsBook
//
//  Created by iOS-School-1 on 02.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ContactList.h"

@interface ContactList ()
@property(nonatomic, strong) NSArray *contacts;
@end

@implementation ContactList

-(instancetype)initWithArray:(NSArray *)contacts{
    self = [super init];
    if(self){
        self.contacts = contacts;
    }
    return self;
}
@end
