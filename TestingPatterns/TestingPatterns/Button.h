//
//  Button.h
//  TestingPatterns
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;



/**
 Список кнопок
 
 - ButtonTypeDefault:
 - ButtonTypeAdd: 
 - ButtonTypeRemove: 
 
 */
typedef NS_ENUM(uint8_t, ButtonType) {// instead of uint8_t can use NSInteger
    ButtonTypeDefault,// = 0
    ButtonTypeAdd,// = 1
    ButtonTypeRemove// = 2
//    ButtonTypeInfo
}; // says which subclasses we have



/**
 <#Description#>
 */
@interface Button : NSObject

/**
 <#Description#>

 @param type <#type description#>
 @return <#return value description#>
 */
+ (instancetype)buttonWithType:(ButtonType)type;


/**
 <#Description#>
 */
- (void)draw;


/**
 <#Description#>

 @return <#return value description#>
 */
- (CGSize)size;

@end
