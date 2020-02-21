//
//  FBPictureCellDelegate.h
//  FlickrBinarization
//
//  Created by Admin on 19.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBPictureCell.h"
@class FBSearchViewController;

@interface FBPictureCellDelegate : NSObject <FBPictureCellDelegate>

- (instancetype)initWithSearchViewController:(FBSearchViewController *)searchViewController;

@end
