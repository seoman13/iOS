//
//  Observer.h
//  TestingPatterns
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EventType) {
    EventTypeAddItem,
    EventTypeRemoveItem,
    EventTypeUpdateItem
};

@protocol ObserverProtocol <NSObject>

- (void)didRecieveEvent:(EventType)type;

@end

@interface Observer : NSObject

- (void)addObserver:(id<ObserverProtocol>)observer forEvent:(EventType)type;
- (void)removeObserver:(id<ObserverProtocol>)observer forEvent:(EventType)type;
- (void)removeAllObservers;

- (void)sendEvent:(EventType)type;

@end
