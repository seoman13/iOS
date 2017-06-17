//
//  Button.m
//  HelloWorldPattern
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Button.h"
#import "ButtonPrintOne.h"
#import "ButtonPrintTwo.h"
#import "ButtonPrintThree.h"



@implementation Button

+ (instancetype)buttonWithType:(ButtonType)type {
    Button *button = nil;
    switch (type) {
        case ButtonTypePrintOne: {
            button = [ButtonPrintOne new];
            break;
        }
        case ButtonTypePrintTwo: {
            button = [ButtonPrintTwo new];
            break;
        }
        case ButtonTypePrintThree: {
            button = [ButtonPrintThree new];
            break;
        }
    }// if no default, but enum has more elements will get warning
    return button;
}

- (void)print {
    NSAssert(NO, @"Implement this method");
}

@end
