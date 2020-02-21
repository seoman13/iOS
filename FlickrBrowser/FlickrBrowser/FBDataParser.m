//
//  FBDataParser.m
//  FlickrBrowser
//
//  Created by Admin on 26.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBDataParser.h"
#import "FBPictureItem.h"

@implementation FBDataParser
// parse Array with Dictionaries representing data of each downloaded element
// with options(things we need to get from these elements)
+ (void)parseDataArray:(NSArray <NSDictionary *> *)dataArray withParameters:(NSDictionary *)parameters success:(void(^)(NSArray <NSDictionary *> *))success failure:(void(^)(NSError *))failure {
    @try {
        NSMutableArray *elements = [NSMutableArray new];
        for (NSDictionary *element in dataArray) {
            NSMutableDictionary *info = [NSMutableDictionary new];
            for (NSString *key in parameters) {
                info[key] = element[parameters[key]] ? element[parameters[key]] : @"";
            }
            [elements addObject:info];
        }
        success(elements);
    } @catch (NSException *exception) {
        NSLog(@"Exception thrown: %@", exception);
        NSError *error;
        failure(error);
    }
}
// parse dataArray exlusively for new search requests for new pictures
+ (void)parseDataArray:(NSArray <NSDictionary *> *)dataArray withPage:(NSInteger)page parameters:(NSDictionary *)parameters success:(void(^)(NSArray <NSDictionary *> *))success failure:(void(^)(NSError *))failure {
    @try {
        NSMutableArray *elements = [NSMutableArray new];
        long i = (page - 1) * 20;
        for (NSDictionary *element in dataArray) {
            NSMutableDictionary *info = [NSMutableDictionary new];
            for (NSString *key in parameters) {
                info[key] = element[parameters[key]] ? element[parameters[key]] : @"";
            }
            NSNumber *sortNumber = [NSNumber numberWithLong:i++];
            info[@"sortNumber"] = sortNumber;
            [elements addObject:info];
        }
        success(elements);
    } @catch (NSException *exception) {
        NSLog(@"Exception thrown: %@", exception);
        NSError *error;
        failure(error);
    }
}

// Parse Search Pictures
+ (void)parsePicturesSearchFromData:(NSData *)data page:(NSInteger)page success:(void(^)(NSArray <NSDictionary *> *))success failure:(void(^)(NSError *))failure {
    NSError *err = nil;
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    if (err) {
        NSLog(@"Couldn't parse JSON. Error: %@", err.localizedDescription);
    }
    NSArray *dataArray = responseJSON[@"photos"][@"photo"];
    NSDictionary *parameters = @{@"pictureId":@"id",
                                 @"secret":@"secret",
                                 @"server":@"server",
                                 @"farm":@"farm",
                                 @"userName":@"ownername",
                                 @"userId":@"owner",
                                 @"iconServer":@"iconserver",
                                 @"iconFarm":@"iconfarm",
                                 @"views":@"views",
                                 @"placeId":@"place_id",
                                 @"pictureDescription":@"description"
                                 };
    [self parseDataArray:dataArray withPage:page parameters:parameters success:^(NSArray<NSDictionary *> *infoArray) {
        NSMutableArray *newArray = [NSMutableArray new];
        for (NSDictionary *info in infoArray) {
            NSDictionary *newDict = [self parseWebDict:info];
            [newArray addObject:newDict];
        }
        success(newArray);
    } failure:failure];
}

+ (NSDictionary *)parseWebDict:(NSDictionary *)info {
    NSString *pictureId = info[@"pictureId"];
    NSString *secret = info[@"secret"];
    NSString *server = info[@"server"];
    NSNumber *farm = info[@"farm"];
    NSString *userName = info[@"userName"];
    NSString *userId = info[@"userId"];
    NSString *iconServer = info[@"iconServer"];
    NSNumber *iconFarm = info[@"iconFarm"];
    NSString *views = info[@"views"];
    
    NSMutableDictionary *mutableInfo = [NSMutableDictionary new];
    mutableInfo[@"avatarUrlString"] = [FBPictureItem createAvatarUrlStringWithIconFarm:[iconFarm integerValue] iconServer:iconServer userId:userId];
    mutableInfo[@"pictureId"] = pictureId;
    mutableInfo[@"pictureDescription"] = info[@"pictureDescription"][@"_content"];
    mutableInfo[@"pictureUrlString"] = [FBPictureItem createPictureUrlStringWithPictureId:pictureId secret:secret server:server farm:[farm integerValue]];
    mutableInfo[@"placeId"] = info[@"placeId"];
    mutableInfo[@"sortNumber"] = info[@"sortNumber"];
    mutableInfo[@"userName"] = userName;
    mutableInfo[@"views"] = views;
    
    return mutableInfo;
}

// Parse Picture Info
+ (void)parsePictureInfoFromData:(NSData *)data success:(void(^)(NSArray *))success failure:(void(^)(NSError *))failure {
    NSError *err = nil;
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    if (err) {
        NSLog(@"Couldn't parse JSON. Error: %@", err.localizedDescription);
        failure(err);
    }
    NSDictionary *photoInfo = responseJSON[@"photo"];
    NSArray *dataArray = @[photoInfo];
    NSDictionary *parameters = @{@"commentsDict":@"comments",
                                 @"locationDict":@"location"};
    [self parseDataArray:dataArray withParameters:parameters success:^(NSArray<NSDictionary *> *info) {
        NSDictionary *infoDict = [info firstObject];
        NSDictionary *newInfo;
        NSString *commentsCount = infoDict[@"commentsDict"][@"_content"];
        if ([infoDict[@"locationDict"] isKindOfClass:[NSString class]]) {
            newInfo = @{@"commentsCount":commentsCount, @"hasLocation":@NO};
        } else {
            NSString *country = infoDict[@"locationDict"][@"country"][@"_content"];
            NSString *town = infoDict[@"locationDict"][@"locality"][@"_content"];
            newInfo = @{@"country":country, @"town":town, @"commentsCount":commentsCount, @"hasLocation":@YES};
        }
        success(@[newInfo]);
    } failure:failure];
}
// Parse Place Info
+ (void)parsePlaceInfoFromData:(NSData *)data success:(void(^)(NSArray *))success failure:(void(^)(NSError *))failure {
    
}
///////////////////////////////////////////
// Parse Picture Favorites
+ (void)parsePictureFavoritesFromData:(NSData *)data success:(void(^)(NSArray *))success failure:(void(^)(NSError *))failure {
    NSError *err = nil;
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    if (err) {
        NSLog(@"Couldn't parse JSON. Error: %@", err.localizedDescription);
    }
    NSDictionary *photoDict = responseJSON[@"photo"];
    NSArray *dataArray = @[photoDict];
    NSDictionary *parameters = @{@"totalLikes":@"total"};
    [self parseDataArray:dataArray withParameters:parameters success:success failure:failure];
}

// Parse Picture Comments
+ (void)parsePictureCommentsFromData:(NSData *)data success:(void(^)(NSArray *))success failure:(void(^)(NSError *))failure {
    NSError *err = nil;
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    if (err) {
        NSLog(@"Couldn't parse JSON. Error: %@", err.localizedDescription);
    }
    NSArray *dataArray = responseJSON[@"comments"][@"comment"];
    NSDictionary *parameters = @{@"userName":@"authorname",
                                 @"userId":@"author",
                                 @"iconServer":@"iconserver",
                                 @"iconFarm":@"iconfarm",
                                 @"comment":@"_content"};
    [self parseDataArray:dataArray withParameters:parameters success:success failure:failure];
}

@end
