//
//  ImageLoadingOperation.h
//  FlickrBinarization
//
//  Created by Admin on 21.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FBSearchViewController;

@interface ImageLoadingOperation : NSOperation

- (instancetype)initWithURLString:(NSString *)urlString searchViewController:(FBSearchViewController *)searchViewController indexPath:(NSIndexPath *)indexPath;

@end
