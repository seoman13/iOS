//
//  Button.h
//  HelloWorldPattern
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ButtonType) {
    ButtonTypePrintOne,
    ButtonTypePrintTwo,
    ButtonTypePrintThree
};

@interface Button : NSObject

+ (instancetype)buttonWithType:(ButtonType)type;

- (void)print;

@end
