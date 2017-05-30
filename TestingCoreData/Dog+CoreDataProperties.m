//
//  Dog+CoreDataProperties.m
//  TestingCoreData
//
//  Created by iOS-School-1 on 30.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Dog+CoreDataProperties.h"

@implementation Dog (CoreDataProperties)

+ (NSFetchRequest<Dog *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Dog"];
}

@dynamic name;
@dynamic age;
@dynamic persons;

@end
