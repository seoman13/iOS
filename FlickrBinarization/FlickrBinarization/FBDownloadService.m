//
//  FBDownloadService.m
//  FlickrBinarization
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "FBDownloadService.h"
#import "FBPictureList.h"
#import <UIKit/UIKit.h>
#import "FBSearchService.h""

@implementation FBDownloadService

- (FBPictureList *)getPictures:(NSString *)pictureName {
    NSOperationQueue *searchQueue = [NSOperationQueue new];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.qualityOfService = NSQualityOfServiceUtility;
    FBSearchOperation *searchOperation = [FBSearchOperation new];
    searchOperation.name = pictureName;
    [queue addOperation:searchOperation];
    
    //    NSArray <NSString *> *pictureAddresses =
    
    NSTimeInterval start = [NSDate date].timeIntervalSince1970;
    
    SearchService *manager = [[SearchService alloc] init];
    NSArray <NSString *> *pictureAddresses = [manager getPicturesAddresses:pictureName];
    
    NSTimeInterval endTime = [NSDate date].timeIntervalSince1970;
    NSLog(@"%f", endTime-start);
    
    NSMutableArray <UIImage *>*pictures = [NSMutableArray new];
    
    //    NSURL *url;
    //    NSData *data;
    //    NSError *error = nil;
    
    //    for (NSString *pictureURL in pictureAddresses) {
    //        url = [NSURL URLWithString:pictureURL];
    //        data = [NSData dataWithContentsOfURL:url options:0 error:&error];
    //        if (error) {
    ////            [pictures addObject:nil];
    //        } else {
    //            [pictures addObject:[UIImage imageWithData:data]];
    //        }
    //    }
    
    for (NSString *pictureURL in pictureAddresses) {
        url = [NSURL URLWithString:pictureURL];
        data = [NSData dataWithContentsOfURL:url options:0 error:&error];
        if (error) {
            //            [pictures addObject:nil];
        } else {
            [pictures addObject:[UIImage imageWithData:data]];
        }
    }
    return [[PictureList alloc] initWithArray:pictures];
}

@end

