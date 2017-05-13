//
//  Playlist.h
//  MusicPlayer
//
//  Created by Admin on 10.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Song;

@interface Playlist : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSMutableSet *list;

-(instancetype) initWithName: (NSString *) name;
-(void) addSong: (Song *) song;
-(void) removeSong: (Song *) song;

-(void)print;
-(BOOL)isEqual:(Playlist *)pl;
@end
