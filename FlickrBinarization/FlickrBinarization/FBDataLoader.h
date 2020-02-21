//
//  FBDataLoader.h
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FBSearchViewController;

@interface FBDataLoader : NSObject

+ (void)loadDataByTerm:(NSString *)term andPageNumber:(NSNumber *)page intoFBSearchViewController:(FBSearchViewController *)searchViewController;

@end
