//
//  ImageSetter.h
//  FlickrBinarization
//
//  Created by Admin on 21.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FBSearchViewController;
@class FBPictureCell;

@interface ImageSetter : NSObject

+ (void)setColorfulImage:(NSString *)imageUrlString inSearchViewController:(FBSearchViewController *)searchViewController forCell:(FBPictureCell *)cell atIndexPath:(NSIndexPath *)indexPath;

+ (void)setBinarizedImage:(NSString *)imageUrlString inSearchViewController:(FBSearchViewController *)searchViewController forCell:(FBPictureCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
