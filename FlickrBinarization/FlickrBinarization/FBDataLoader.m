//
//  FBDataLoader.m
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "FBDataLoader.h"
#import "FBSearchViewController.h"
#import "FBDataParser.h"

@implementation FBDataLoader

+ (void)loadDataByTerm:(NSString *)term andPageNumber:(NSNumber *)page intoFBSearchViewController:(FBSearchViewController *)searchViewController {
    // Turn on networkActivityIndicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // Create url
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=caad36f46cb06f7b32c7ea69457cc7f9&content_type=1&sort=relevance&text=%@&per_page=20&page=%li&format=json&nojsoncallback=1", term, (long)page.integerValue];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                if (data) {
                    [FBDataParser updateSearchResults:data withNextPage:page intoSearchViewController:searchViewController];
                } else {
                    NSLog(@"Recieved empty data from server");
                }
            } else {
                NSLog(@"Server Error");
            }
        } else {
            NSLog(@"Couldn't complete request. Error: %@", error);
        }
    }];
    [dataTask resume];
}

@end
