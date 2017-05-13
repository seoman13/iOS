//
//  Song.m
//  MusicPlayer
//
//  Created by Admin on 10.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Song.h"

@implementation Song
-(instancetype) initWithTitle:(NSString *) title Artist:(NSString *) artist Album:(NSString *) album  AndPlayingTime:(int) time{
    self = [super init];
    if(self){
        self.title = title;
        self.album = album;
        self.artist = artist;
        self.playingTime = time;
    }
    return self;
}

-(instancetype) init{
    return [self initWithTitle:@"Unknown" Artist:@"Unknown" Album:@"Unknown" AndPlayingTime:0];
    
}

-(BOOL)isEqual:(Song *)song{
    if(self.title == song.title && self.artist == song.artist && self.album == self.album)
        return YES;
    return NO;
}

@end
