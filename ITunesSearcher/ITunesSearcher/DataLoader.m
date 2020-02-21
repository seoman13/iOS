//
//  DataLoader.m
//  ITunesSearcher
//
//  Created by Admin on 16.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "DataLoader.h"
#import "ISSearchViewController.h"

@implementation DataLoader

+ (void)loadDataByTerm:(NSString *)term intoSearchViewController:(ISSearchViewController *)searchViewController {
    if (![term isEqualToString:@""]) {
        // Check if data task is at work, if so - cancel it
        if (searchViewController.dataTask != nil) {
            [searchViewController.dataTask cancel];
        }
        // Show Network Activity Indicator
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        // 3
        NSCharacterSet *expectedCharSet = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *searchTerm = [term stringByAddingPercentEncodingWithAllowedCharacters:expectedCharSet];
        
        // Create URL for data task
        NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?media=music&entity=song&term=%@&limit=50", searchTerm];
        NSURL *url = [NSURL URLWithString:urlString];
        
        // 5
        searchViewController.dataTask = [searchViewController.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // Stop Network Activity Indicator
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
            // 7
            if (!error) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if (httpResponse.statusCode == 200) {
                    [searchViewController updateSearchResults:data];
                }
            } else {
                NSLog(@"Couldn't complete data task. Error: %@", error);
            }
        }];
        // 8
        [searchViewController.dataTask resume];
    }
}

@end
