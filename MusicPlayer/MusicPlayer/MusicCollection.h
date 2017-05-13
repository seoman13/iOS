//
//  MusicCollection.h
//  MusicPlayer
//
//  Created by Admin on 10.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Song;
@class Playlist;

@interface MusicCollection : NSObject

@property(nonatomic, strong) NSMutableSet *list, *library;

-(void) addPlaylist: (Playlist *) pl;
-(void) removePlaylist: (Playlist *) pl;

-(void)printLibrary;
-(void)printPlaylists;
-(void)removeSong: (Song *)song;
@end
