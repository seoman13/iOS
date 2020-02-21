//
//  FBDataLoaderFromFlickr.h
//  FlickrBrowser
//
//  Created by Admin on 24.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FBSearchPanelViewController;

@interface FBDataLoaderFromFlickr : NSObject

+ (void)getDataWithRequest:(NSURLRequest *)request success:(void(^)(NSData *))success failure:(void(^)(NSError *))failure;
+ (void)getDataWithRequest:(NSURLRequest *)request andPage:(NSInteger)page success:(void(^)(NSData *, NSInteger))success failure:(void(^)(NSError *))failure;

@end
