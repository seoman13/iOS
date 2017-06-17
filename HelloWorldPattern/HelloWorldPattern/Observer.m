//
//  Observer.m
//  TestingPatterns
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Observer.h"

@interface Observer ()

@property (nonatomic, strong) NSMutableSet <id<ObserverProtocol>> *printOneObservers;
@property (nonatomic, strong) NSMutableSet <id<ObserverProtocol>> *printTwoObservers;
@property (nonatomic, strong) NSMutableSet <id<ObserverProtocol>> *printThreeObservers;

@end

@implementation Observer

- (instancetype)init {
    self = [super init];
    if (self) {
        _printOneObservers = [NSMutableSet new];
        _printTwoObservers = [NSMutableSet new];
        _printThreeObservers = [NSMutableSet new];
    }
    return self;
}

- (void)addObserver:(id<ObserverProtocol>)observer forEvent:(EventType)type {
    switch (type) {
        case EventTypePrintOne: {
            [_addObservers addObject:observer];
            break;
        }
        case EventTypePrintTwo: {
            [_removeObservers addObject:observer];
            break;
        }
        case EventTypePrintThree: {
            [_updateObservers addObject:observer];
            break;
        }
    }
}

- (void)removeObserver:(id<ObserverProtocol>)observer forEvent:(EventType)type {
    switch (type) {
        case EventTypePrintOne: {
            [_addObservers removeObject:observer];
            break;
        }
        case EventTypePrintTwo: {
            [_removeObservers removeObject:observer];
            break;
        }
        case EventTypePrintThree: {
            [_updateObservers removeObject:observer];
            break;
        }
    }
}

- (void)removeAllObservers {
    [_addObservers removeAllObjects];
    [_removeObservers removeAllObjects];
    [_updateObservers removeAllObjects];
}

- (void)sendEvent:(EventType)type {
    switch (type) {
        case EventTypeAddItem: {
            [_addObservers.allObjects enumerateObjectsUsingBlock:^(id<ObserverProtocol>  _Nonnull observer, NSUInteger idx, BOOL * _Nonnull stop) {
                [observer didRecieveEvent:EventTypeAddItem];
            }];
            break;
        }
        case EventTypeRemoveItem: {
            [_addObservers.allObjects enumerateObjectsUsingBlock:^(id<ObserverProtocol>  _Nonnull observer, NSUInteger idx, BOOL * _Nonnull stop) {
                [observer didRecieveEvent:EventTypeRemoveItem];
            }];
            break;
        }
        case EventTypeUpdateItem: {
            [_addObservers.allObjects enumerateObjectsUsingBlock:^(id<ObserverProtocol>  _Nonnull observer, NSUInteger idx, BOOL * _Nonnull stop) {
                [observer didRecieveEvent:EventTypeUpdateItem];
            }];
            break;
        }
    }
}

@end
