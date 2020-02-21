//
//  FBDataLoaderFromFlickr.m
//  FlickrBrowser
//
//  Created by Admin on 24.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBDataLoaderFromFlickr.h"
#import "FBSearchPanelViewController.h"
#import "FBRouter.h"
#import "FBDataParser.h"
#import "FBPictureItem.h"

@implementation FBDataLoaderFromFlickr

+ (void)getDataWithRequest:(NSURLRequest *)request success:(void(^)(NSData *))success failure:(void(^)(NSError *))failure {
    // Turn on networkActivityIndicator
	dispatch_async(dispatch_get_main_queue(), ^{
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	});
    // Create DataTask
    NSURLSessionDataTask *dataTask = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		});
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                if (data) {
                    success(data);
                } else {
                    NSLog(@"Recieved empty data from server");
                }
            } else {
                NSLog(@"Server Error. StatusCode %li", httpResponse.statusCode);
            }
        } else {
            NSLog(@"Couldn't complete request. Error: %@", error.localizedDescription);
            failure(error);
        }
    }];
    [dataTask resume];
}

+ (void)getDataWithRequest:(NSURLRequest *)request andPage:(NSInteger)page success:(void(^)(NSData *, NSInteger))success failure:(void(^)(NSError *))failure {
    // Turn on networkActivityIndicator
	dispatch_async(dispatch_get_main_queue(), ^{
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	});
    // Create DataTask
    NSURLSessionDataTask *dataTask = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		});
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                if (data) {
                    success(data, page);
                } else {
                    NSLog(@"Recieved empty data from server");
                }
            } else {
                NSLog(@"Server Error. StatusCode %li", httpResponse.statusCode);
            }
        } else {
            NSLog(@"Couldn't complete request. Error: %@", error.localizedDescription);
            failure(error);
        }
    }];
    [dataTask resume];
}

@end
