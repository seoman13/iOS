//
//  FBDownloadService.h
//  FlickrBinarization
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBPictureList.h"
#import "FBPictureManager.h"

@interface FBDownloadService : NSObject <FBPictureManager>

- (FBPictureList *)getPictures:(NSString *)pictureName;

@end
