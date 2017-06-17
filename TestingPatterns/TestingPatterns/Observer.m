//
//  Observer.m
//  TestingPatterns
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Observer.h"

@interface Observer ()

@property (nonatomic, strong) NSMutableSet <id<ObserverProtocol>> *addObservers;
@property (nonatomic, strong) NSMutableSet <id<ObserverProtocol>> *removeObservers;
@property (nonatomic, strong) NSMutableSet <id<ObserverProtocol>> *updateObservers;

@end

@implementation Observer

- (instancetype)init {
    self = [super init];
    if (self) {
        _addObservers = [NSMutableSet new];
        _removeObservers = [NSMutableSet new];
        _updateObservers = [NSMutableSet new];
    }
    return self;
}

- (void)addObserver:(id<ObserverProtocol>)observer forEvent:(EventType)type {
    switch (type) {
        case EventTypeAddItem: {
            [_addObservers addObject:observer];
            break;
        }
        case EventTypeRemoveItem: {
            [_removeObservers addObject:observer];
            break;
        }
        case EventTypeUpdateItem: {
            [_updateObservers addObject:observer];
            break;
        }
    }
}

- (void)removeObserver:(id<ObserverProtocol>)observer forEvent:(EventType)type {
    switch (type) {
        case EventTypeAddItem: {
            [_addObservers removeObject:observer];
            break;
        }
        case EventTypeRemoveItem: {
            [_removeObservers removeObject:observer];
            break;
        }
        case EventTypeUpdateItem: {
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
