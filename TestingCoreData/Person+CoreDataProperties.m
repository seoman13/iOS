//
//  Person+CoreDataProperties.m
//  TestingCoreData
//
//  Created by iOS-School-1 on 30.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic firstName;
@dynamic age;
@dynamic lastNmae;
@dynamic birthday;
@dynamic identifier;
@dynamic photo_preview;
@dynamic photo;
@dynamic dog;

@end
