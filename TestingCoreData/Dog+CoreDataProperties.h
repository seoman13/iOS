//
//  Dog+CoreDataProperties.h
//  TestingCoreData
//
//  Created by iOS-School-1 on 30.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Dog+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Dog (CoreDataProperties)

+ (NSFetchRequest<Dog *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, retain) NSSet<Dog *> *persons;

@end

@interface Dog (CoreDataGeneratedAccessors)

- (void)addPersonsObject:(Dog *)value;
- (void)removePersonsObject:(Dog *)value;
- (void)addPersons:(NSSet<Dog *> *)values;
- (void)removePersons:(NSSet<Dog *> *)values;

@end

NS_ASSUME_NONNULL_END
