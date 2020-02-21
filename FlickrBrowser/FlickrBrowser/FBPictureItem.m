//
//  FBPictureItem.m
//  FlickrBrowser
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBPictureItem.h"

@implementation FBPictureItem

@dynamic avatarUrlString;
@dynamic numOfFavs;
@dynamic pictureId;
@dynamic pictureDescription;
@dynamic pictureUrlString;
@dynamic placeId;
@dynamic sortNumber;
@dynamic userName;
@dynamic views;

+ (NSString *)createPictureUrlStringWithPictureId:(NSString *)pictureId secret:(NSString *)secret server:(NSString *)server farm:(u_int16_t)farm {
    NSString *pictureUrlString = [NSString stringWithFormat:@"https://farm%i.staticflickr.com/%@/%@_%@.jpg", farm, server, pictureId, secret];
    return pictureUrlString;
}

+ (NSString *)createAvatarUrlStringWithIconFarm:(u_int16_t)iconFarm iconServer:(NSString *)iconServer userId:(NSString *)userId {
    NSString *avatarUrlString;
    if (iconFarm == 0) {
        avatarUrlString = @"https://www.flickr.com/images/buddyicon.gif";
    } else {
        avatarUrlString = [NSString stringWithFormat:@"http://farm%i.staticflickr.com/%@/buddyicons/%@.jpg", iconFarm, iconServer, userId];
    }
    return avatarUrlString;
}

@end
