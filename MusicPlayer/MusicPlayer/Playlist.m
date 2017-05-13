//
//  Playlist.m
//  MusicPlayer
//
//  Created by Admin on 10.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Playlist.h"
#import "Song.h"

@implementation Playlist

-(instancetype) initWithName: (NSString *) name{
    self = [super init];
    if(self){
        self.name = name;
        self.list = [NSMutableSet new];
    }
    return self;
}

-(instancetype) init{
    return [self initWithName:@"NoName"];
}

-(void) addSong:(Song *)song{
    [self.list addObject:song];
}

-(void) removeSong:(Song *)song{
    if([self.list containsObject:song] != YES){
        NSLog(@"%@", @"Song is not in the Playlist!");
    }
    [self.list removeObject:song];
}

-(void)print{
    NSLog(@"Playlist %@", self.name);
    for(Song *song in self.list){
        NSLog(@"Song: %@, Artist: %@, Album: %@, Duration: %i", song.title, song.artist, song.album, song.playingTime);
    }
}

-(BOOL)isEqual:(Playlist *)pl{
    if(self.name == pl.name)
        return YES;
    return NO;
}
@end
