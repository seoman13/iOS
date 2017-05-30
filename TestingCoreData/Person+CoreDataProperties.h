//
//  Person+CoreDataProperties.h
//  TestingCoreData
//
//  Created by iOS-School-1 on 30.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *lastNmae;
@property (nonatomic) NSTimeInterval birthday;
@property (nonatomic) double identifier;
@property (nullable, nonatomic, retain) NSData *photo_preview;
@property (nullable, nonatomic, retain) NSObject *photo;
@property (nullable, nonatomic, retain) Person *dog;

@end

NS_ASSUME_NONNULL_END
