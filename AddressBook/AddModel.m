//
//  AddModel.m
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AddModel.h"
#import "Contact.h"

@interface AddModel ()
@property(nonatomic, strong) NSArray *contacts;
@end

@implementation AddModel

-(instancetype)init{
    self = [super init];
    if(self){
        self.contacts = @[@"Brad Pitt",
                          @"Angelina Jolie",
                          @"Kate Backinsale",
                          @"Johnny Depp",
                          @"Charlize Theron",
                          @"Natalie Portman"];
    }
    return self;
}

//-(void) addContact:(Contact *)person{
//    [self.contacts addObject:person];
//}

-(NSArray *)getContacts{
    return self.contacts;
}
@end
