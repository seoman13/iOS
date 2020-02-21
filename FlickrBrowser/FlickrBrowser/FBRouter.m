//
//  FBRouter.m
//  FlickrBrowser
//
//  Created by Admin on 25.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBRouter.h"
#import "FBNetworkConstants.h"

NSString * const api_key = @"caad36f46cb06f7b32c7ea69457cc7f9";

@implementation FBRouter

#pragma mark - Flickr Pictures Search
+ (NSURLRequest *)newPicturesSearchRequestWithQuery:(NSString *)query atPage:(NSInteger)page {
    NSString *urlString = [NSString stringWithFormat:@"%@%@&api_key=%@&content_type=1&sort=relevance&text=%@&per_page=20&page=%li&extras=owner_name,geo,views,icon_server,description&%@", FBBaseFlickrApiURL, FBPhotoSearchMethod, api_key, query, page, FBCommonPartURL];
    return [FBRouter requestWithURLString:urlString];
}

#pragma mark - Flickr Picture Info
+ (NSURLRequest *)pictureInfoRequestWithPictureId:(NSString *)pictureId {
    NSString *urlString = [NSString stringWithFormat:@"%@%@&api_key=%@&photo_id=%@&%@", FBBaseFlickrApiURL, FBPhotoInfoMethod, api_key, pictureId, FBCommonPartURL];
    return [FBRouter requestWithURLString:urlString];
}

+ (NSURLRequest *)pictureNumberOfFavoritesRequestWithPictureId:(NSString *)pictureId {
    NSString *urlString = [NSString stringWithFormat:@"%@%@&api_key=%@&photo_id=%@&page=1&%@", FBBaseFlickrApiURL, FBGetFavoritesMethod, api_key, pictureId, FBCommonPartURL];
    return [FBRouter requestWithURLString:urlString];
}

+ (NSURLRequest *)pictureCommentsRequestWithPictureId:(NSString *)pictureId {
    NSString *urlString = [NSString stringWithFormat:@"%@%@&api_key=%@&photo_id=%@&%@", FBBaseFlickrApiURL, FBGetCommentsListMethod, api_key, pictureId, FBCommonPartURL];
    return [FBRouter requestWithURLString:urlString];
}

#pragma mark - Flickr Place Info
+ (NSURLRequest *)placeInfoRequestWithPlaceId:(NSString *)placeId {
    NSString *urlString = [NSString stringWithFormat:@"%@%@&api_key=%@&place_id=%@&%@", FBBaseFlickrApiURL, FBPlaceInfoMethod, api_key, placeId, FBCommonPartURL];
    return [FBRouter requestWithURLString:urlString];
}

#pragma mark - Create NSURLMutableRequest from urlString
+ (NSMutableURLRequest *)requestWithURLString:(NSString *)URLString {
    NSURL *url = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    return request;
}

@end
