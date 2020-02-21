//
//  ISTrack.h
//  ITunesSearcher
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISTrack : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSString *trackPrice;
@property (nonatomic, copy) NSString *previewURL;
@property (nonatomic, copy) NSString *artworkUrl60;
@property (nonatomic, copy) NSString *artworkUrl100;
@property (nonatomic, copy) NSString *trackID;

- (instancetype)initWithName:(NSString *)name artist:(NSString *)artist album:(NSString *)album price:(NSString *)trackPrice previewURL:(NSString *)previewURL artworkUrl60:(NSString *)artworkUrl60 artworkUrl100:(NSString *)artworkUrl100 trackID:(NSString *)trackID;

@end
