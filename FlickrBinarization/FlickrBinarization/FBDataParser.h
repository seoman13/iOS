//
//  FBDataParser.h
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FBSearchViewController;

@interface FBDataParser : NSObject

+ (void)updateSearchResults:(NSData *)data withNextPage:(NSNumber *)page intoSearchViewController:(FBSearchViewController *)searchViewController;

//+ (NSString *)createPictureUrlWithPictureId:(NSString *)pictureId secret:(NSString *)secret server:(NSString *)server farm:(NSString *)farm;

@end
