//
//  FBDataParser.h
//  FlickrBrowser
//
//  Created by Admin on 26.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBDataParser : NSObject
// Parse Search Pictures
+ (void)parsePicturesSearchFromData:(NSData *)data page:(NSInteger)page success:(void(^)(NSArray <NSDictionary *> *))success failure:(void(^)(NSError *))failure;
// Parse Picture Info
+ (void)parsePictureInfoFromData:(NSData *)data success:(void(^)(NSArray *))success failure:(void(^)(NSError *))failure;
// Parse Place Info
+ (void)parsePlaceInfoFromData:(NSData *)data success:(void(^)(NSArray *))success failure:(void(^)(NSError *))failure;
// Parse Picture Favorites
+ (void)parsePictureFavoritesFromData:(NSData *)data success:(void(^)(NSArray *))success failure:(void(^)(NSError *))failure;
// Parse Picture Comments
+ (void)parsePictureCommentsFromData:(NSData *)data success:(void(^)(NSArray *))success failure:(void(^)(NSError *))failure;

@end
