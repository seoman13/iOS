//
//  FBImageFilter.h
//  FlickrBinarization
//
//  Created by Admin on 21.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
@class FBSearchViewController;

@interface FBImageFilter : NSObject

+ (void)binarizeImage:(UIImage *)image inSearchViewController:(FBSearchViewController *)searchViewController atIndexPath:(NSIndexPath *)indexPath;

@end
