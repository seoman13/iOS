//
//  FBNetworkConstants.m
//  FlickrBrowser
//
//  Created by Admin on 25.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBNetworkConstants.h"

NSString * const FBBaseFlickrApiURL = @"https://api.flickr.com/services/rest/?";
NSString * const FBCommonPartURL = @"format=json&nojsoncallback=1";
// Methods
NSString * const FBPhotoSearchMethod = @"method=flickr.photos.search";
NSString * const FBPhotoInfoMethod = @"method=flickr.photos.getInfo";
NSString * const FBUserInfoMethod = @"method=flickr.people.getInfo";
NSString * const FBPlaceInfoMethod = @"method=flickr.places.getInfo";
NSString * const FBGetFavoritesMethod = @"method=flickr.photos.getFavorites";
NSString * const FBGetCommentsListMethod = @"method=flickr.photos.comments.getList";

