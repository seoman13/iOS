//
//  MusicCollection.m
//  MusicPlayer
//
//  Created by Admin on 10.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "MusicCollection.h"
#import "Song.h"
#import "Playlist.h"

@implementation MusicCollection

-(instancetype) init{
    self = [super init];
    if(self){
        self.list = [NSMutableSet new];
        self.library = [NSMutableSet new];
    }
    return self;
}

-(void) addPlaylist: (Playlist *) pl{
    if([self.list containsObject:pl] == NO){
        [self.list addObject: pl];
        for(Song *song in pl.list)
            [self.library addObject:song];
    }
}

-(void) removePlaylist: (Playlist *) pl{
    [self.list removeObject:pl];
//    for(Song *song in pl.list)
//        [self.library removeObjectIdenticalTo:song];
}

-(void)removeSong: (Song *)song{
    if([self.library containsObject:song] == NO)
        NSLog(@"There's no such song!");
    else{
        [self.library removeObject:song];
        for(Playlist *pl in self.list)
            [pl.list removeObject:song];
        }
}

-(void)printLibrary{
    for(Song *song in self.library)
        NSLog(@"%@", song.title);
}

-(void)printPlaylists{
    for(Playlist *pl in self.list){
        [pl print];
    }
}
@end
