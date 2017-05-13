//
//  main.m
//  MusicPlayer
//
//  Created by Admin on 09.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"
#import "Playlist.h"
#import "MusicCollection.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Song *song1 = [[Song alloc] initWithTitle:@"Unstoppable" Artist:@"Sia" Album:@"Unknown"  AndPlayingTime:214];
        Song *song2 = [[Song alloc] initWithTitle:@"Numb" Artist:@"Linkin Park" Album:@"Numb"  AndPlayingTime:210];
        Song *song3 = [[Song alloc] initWithTitle:@"Divide" Artist:@"Linkin Park" Album:@"Unknown"  AndPlayingTime:219];
        Song *song4 = [[Song alloc] initWithTitle:@"Viva La Vida" Artist:@"Coldplay" Album:@"Viva La Vida"  AndPlayingTime:200];
        Song *song5 = [[Song alloc] initWithTitle:@"Chandelier" Artist:@"Sia" Album:@"Unknown"  AndPlayingTime:214];
        Song *song6 = [[Song alloc] initWithTitle:@"Don't Stop" Artist:@"Queen" Album:@"Unknown"  AndPlayingTime:214];
        
        Playlist *playlist1 = [[Playlist alloc] initWithName:@"Favorite"];
        [playlist1 addSong:song1];
        [playlist1 addSong:song1];
        [playlist1 addSong:song3];
        [playlist1 addSong:song4];
        
        Playlist *playlist2 = [[Playlist alloc] initWithName:@"Big"];
        [playlist2 addSong:song1];
        [playlist2 addSong:song1];
        [playlist2 addSong:song2];
        [playlist2 addSong:song5];
        [playlist2 addSong:song5];
        [playlist2 addSong:song3];
        
        Playlist *playlist3 = [[Playlist alloc] initWithName:@"Lame"];
        [playlist3 addSong:song2];
        [playlist3 addSong:song2];
        [playlist3 addSong:song3];
        [playlist3 addSong:song5];
        [playlist3 addSong:song6];
        
        MusicCollection *collection1 = [[MusicCollection alloc] init];
        
        [collection1 addPlaylist:playlist1];
        [collection1 addPlaylist:playlist2];
        [collection1 addPlaylist:playlist3];
        
//        [playlist1 print];
//        [playlist2 print];
        //[playlist3 print];
        
        [collection1 printLibrary];
        [collection1 printPlaylists];
        
        //[playlist3 removeSong:song1];
        //[playlist3 removeSong:song6];
        //[playlist3 print];
        
        [collection1 removeSong:song6];
        [collection1 removeSong:song3];
        
        [collection1 printLibrary];
        [collection1 printPlaylists];
    }
    return 0;
}
