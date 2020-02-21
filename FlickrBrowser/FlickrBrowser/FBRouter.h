//
//  FBRouter.h
//  FlickrBrowser
//
//  Created by Admin on 25.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBRouter : NSObject

#pragma mark - Flickr Pictures Search
+ (NSURLRequest *)newPicturesSearchRequestWithQuery:(NSString *)query atPage:(NSInteger)page;

#pragma mark - Flickr Picture Info
+ (NSURLRequest *)pictureInfoRequestWithPictureId:(NSString *)pictureId;
+ (NSURLRequest *)pictureNumberOfFavoritesRequestWithPictureId:(NSString *)pictureId;
+ (NSURLRequest *)pictureCommentsRequestWithPictureId:(NSString *)pictureId;

#pragma mark - Flickr Place Info
+ (NSURLRequest *)placeInfoRequestWithPlaceId:(NSString *)placeId;

@end
