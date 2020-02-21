//
//  FBImageLoader.h
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FBSearchViewController;

@interface FBImageLoader : NSObject

+ (void)loadImageAtURL:(NSString *)urlString IntoSearchViewController:(FBSearchViewController *)searchViewController atIndexPath:(NSIndexPath *)indexPath;

@end
