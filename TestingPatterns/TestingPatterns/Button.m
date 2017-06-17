//
//  Button.m
//  TestingPatterns
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Button.h"
#import "DefaultButton.h"
#import "AddButton.h"
#import "RemoveButton.h"

@implementation Button

+ (instancetype)buttonWithType:(ButtonType)type {
    Button *button = nil;
    switch (type) {
        case ButtonTypeDefault: {
            button = [DefaultButton new];
            break;
        }
        case ButtonTypeAdd: {
            button = [AddButton new];
            break;
        }
        case ButtonTypeRemove: {
            button = [RemoveButton new];
            break;
        }
    }// if no default, but enum has more elements will get warning
    return button;
}

- (void)draw {
    NSAssert(NO, @"Метод должен быть реализоан в конкретном классе");
}

- (CGSize)size {
    NSAssert(NO, @"Метод должен быть реализоан в конкретном классе");
    return CGSizeZero;
}

@end
