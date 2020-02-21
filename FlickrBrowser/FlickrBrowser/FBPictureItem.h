//
//  FBPictureItem.h
//  FlickrBrowser
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface FBPictureItem : NSManagedObject

@property (copy, nonatomic) NSString *avatarUrlString;
@property (nonatomic) u_int32_t numOfFavs;
@property (copy, nonatomic) NSString *pictureId;
@property (copy, nonatomic) NSString *pictureDescription;
@property (copy, nonatomic) NSString *pictureUrlString;
@property (copy, nonatomic) NSString *placeId;
@property (nonatomic) u_int32_t sortNumber;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *views;

+ (NSString *)createPictureUrlStringWithPictureId:(NSString *)pictureId secret:(NSString *)secret server:(NSString *)server farm:(u_int16_t)farm;

+ (NSString *)createAvatarUrlStringWithIconFarm:(u_int16_t)iconFarm iconServer:(NSString *)iconServer userId:(NSString *)userId;

@end
