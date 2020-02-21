//
//  FBImageManager.h
//  FlickrBrowser
//
//  Created by Admin on 27.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

@interface FBImageManager : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

- (BOOL)cachedImageExistsForURL:(NSURL *)imageURL;
- (UIImage *)cachedImageForURL:(NSURL *)imageURL;
- (BOOL)addImage:(UIImage *)image toCacheForURL:(NSURL *)imageURL;
- (BOOL)removeImageFromCacheForURL:(NSURL *)imageURL;
- (BOOL)removeAllImagesFromCache;

+ (instancetype)sharedManager;

@end
