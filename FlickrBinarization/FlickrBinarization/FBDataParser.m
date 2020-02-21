//
//  FBDataParser.m
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "FBDataParser.h"
#import <UIKit/UIKit.h>
#import "FBImageItem.h"
#import "FBSearchViewController.h"

@implementation FBDataParser

+ (void)updateSearchResults:(NSData *)data withNextPage:(NSNumber *)page intoSearchViewController:(FBSearchViewController *)searchViewController {
    NSError *error = nil;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (!response) {
        NSLog(@"Error parsing data into json");
    }
    NSArray *pictures = response[@"photos"][@"photo"];
    NSMutableArray <NSDictionary *> *imageItems = [NSMutableArray new];
    int i = (page.shortValue - 1) * 20;
    for (NSDictionary *pictureDictionary in pictures) {
        NSNumber *numberWhenAdded = [NSNumber numberWithInt:i++];
        NSString *pictureId = pictureDictionary[@"id"];
        NSString *secret = pictureDictionary[@"secret"];
        NSString *server = pictureDictionary[@"server"];
        NSNumber *farmNumber = pictureDictionary[@"farm"];
        NSString *farm = [NSString stringWithFormat:@"%li", farmNumber.integerValue];
        NSString *urlString = [self createPictureUrlWithPictureId:pictureId secret:secret server:server farm:farm];
        NSDictionary *info = @{@"numberWhenAdded":numberWhenAdded, @"pictureId":pictureId, @"secret":secret, @"server":server, @"farm":farm, @"urlString":urlString};
//        [searchViewController addImageItem:info];
       
//        FBImageItem *item = [FBImageItem new];
//        item.numberWhenAdded = numberWhenAdded;
//        item.pictureId = pictureDictionary[@"id"];
//        item.secret = pictureDictionary[@"secret"];
//        item.server = pictureDictionary[@"server"];
//        item.farm = pictureDictionary[@"farm"];
//        NSString *urlString = [self createPictureUrlWithPictureId:item.pictureId secret:item.secret server:item.server farm:item.farm];
//        item.urlString = urlString;
        [imageItems addObject:info];
    }
    if ([page isEqualToNumber:[NSNumber numberWithInt:1]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            searchViewController.searchResults = imageItems;
//            [searchViewController removeAllImageItems];
            [searchViewController addMultipleImageItems:imageItems];
            [searchViewController.tableView setContentOffset:CGPointZero];
            [searchViewController.tableView reloadData];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
//            [searchViewController.searchResults addObjectsFromArray:imageItems];
            [searchViewController addMultipleImageItems:imageItems];
            [searchViewController.tableView reloadData];
        });
            }
}

+ (NSString *)createPictureUrlWithPictureId:(NSString *)pictureId secret:(NSString *)secret server:(NSString *)server farm:(NSString *)farm {
    NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_c.jpg", farm, server, pictureId, secret];
    return urlString;
}

@end
