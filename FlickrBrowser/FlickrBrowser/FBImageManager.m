//
//  FBImageManager.m
//  FlickrBrowser
//
//  Created by Admin on 27.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBImageManager.h"

static NSCache *imageCache;

@implementation FBImageManager

+ (instancetype)sharedManager {
    static FBImageManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        imageCache = [[NSCache alloc] init];
    });
    return sharedManager;
}

- (BOOL)cachedImageExistsForURL:(NSURL *)imageURL {
    if ([imageCache objectForKey:imageURL.absoluteString]) {
        return YES;
    }
    return NO;
}

- (nullable UIImage *)cachedImageForURL:(NSURL *)imageURL {
    if([self cachedImageExistsForURL:imageURL]) {
        return [imageCache objectForKey:imageURL.absoluteString];
    }
    return nil;
}

- (BOOL)addImage:(UIImage *)image toCacheForURL:(NSURL *)imageURL {
    @try {
        [imageCache setObject:image forKey:imageURL.absoluteString];
        return YES;
    } @catch (NSException *exception) {
        NSLog(@"Couldn't put image in the Cache. Caught Exception: %@", exception);
        return NO;
    }
    return NO;
}

- (BOOL)removeImageFromCacheForURL:(NSURL *)imageURL {
    @try {
        [imageCache removeObjectForKey:imageURL.absoluteString];
        return YES;
    } @catch (NSException *exception) {
        NSLog(@"Couldn't remove image from the Cache. Caught Exception: %@", exception);
        return NO;
    }
    return NO;
}

- (BOOL)removeAllImagesFromCache {
    @try {
        [imageCache removeAllObjects];
        return YES;
    } @catch (NSException *exception) {
        NSLog(@"Couldn't remove images from the Cache. Caught Exception: %@", exception);
        return NO;
    }
    return NO;
}

@end
