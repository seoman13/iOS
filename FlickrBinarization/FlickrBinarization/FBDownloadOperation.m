//
//  FBDownloadOperation.m
//  FlickrBinarization
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "FBDownloadOperation.h"
#import <UIKit/UIKit.h>
#import "FBSearchService.h"

@implementation FBDownloadOperation

- (void)main {

    NSTimeInterval start = [NSDate date].timeIntervalSince1970;
    
    FBSearchService *manager = [[FBSearchService alloc] init];
    NSArray <NSString *> *pictureAddresses = [manager getPicturesAddresses:@"cat"];
    
    NSTimeInterval endTime = [NSDate date].timeIntervalSince1970;
    NSLog(@"%f", endTime-start);
    
    
    NSMutableArray <UIImage *>*pictures = [NSMutableArray new];
    
    NSURL *url;
    NSData *data;
    NSError *error = nil;
    
    for (NSString *pictureURL in pictureAddresses) {
        url = [NSURL URLWithString:pictureURL];
        data = [NSData dataWithContentsOfURL:url options:0 error:&error];
        if (error) {
            //            [pictures addObject:nil];
        } else {
            [pictures addObject:[UIImage imageWithData:data]];
        }
    }
}

@end
