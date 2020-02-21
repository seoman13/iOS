//
//  DataParser.m
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "DataParser.h"
#import "ISSearchViewController.h"
#import "ISTrack.h"

@implementation DataParser

#pragma mark Handling Search Results

+ (void)updateSearchResult:(NSData *)data forSearchViewController:(ISSearchViewController *)searchViewController {
    [searchViewController.searchResults removeAllObjects];
    NSError *error = nil;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"Error Parsing JSON");
    }
    NSArray *array;
    @try {
        array = response[@"results"];
    } @catch (NSException *exception) {
        NSLog(@"Results key not found in dictionary");
    }
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@"$"];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode:NSNumberFormatterRoundDown];
    
    for (NSDictionary *trackDictionary in array) {
        @try {
            NSString *name = trackDictionary[@"trackName"];
            NSString *artist = trackDictionary[@"artistName"];
            NSString *album = trackDictionary[@"collectionName"];
            NSNumber *nsNumberPrice = trackDictionary[@"trackPrice"];
            NSString *trackPrice = [formatter stringFromNumber:nsNumberPrice];
            NSString *previewUrl = trackDictionary[@"previewUrl"];
            NSString *artworkUrl60 = trackDictionary[@"artworkUrl60"];
            NSString *artworkUrl100 = trackDictionary[@"artworkUrl100"];
            NSString *trackId = trackDictionary[@"trackId"];
            ISTrack *track = [[ISTrack alloc] initWithName:name artist:artist album:album price:trackPrice previewURL:previewUrl artworkUrl60:artworkUrl60 artworkUrl100:artworkUrl100 trackID:trackId];
            [searchViewController.searchResults addObject:track];
        } @catch (NSException *exception) {
            NSLog(@"Not a dictionary");
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [searchViewController.tableView reloadData];
        [searchViewController.tableView setContentOffset:CGPointZero];
    });
    
}

@end
