//
//  ISTrack.m
//  ITunesSearcher
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ISTrack.h"

@implementation ISTrack

- (instancetype)initWithName:(NSString *)name artist:(NSString *)artist album:(NSString *)album price:(NSString *)trackPrice previewURL:(NSString *)previewURL artworkUrl60:(NSString *)artworkUrl60 artworkUrl100:(NSString *)artworkUrl100 trackID:(NSString *)trackID {
    self = [super init];
    if (self) {
        self.name = name;
        self.artist = artist;
        self.album = album;
        self.trackPrice = trackPrice;
        self.previewURL = previewURL;
        self.artworkUrl60 = artworkUrl60;
        self.artworkUrl100 = artworkUrl100;
        self.trackID = trackID;
    }
    return self;
}

@end
