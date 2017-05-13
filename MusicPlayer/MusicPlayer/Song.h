//
//  Song.h
//  MusicPlayer
//
//  Created by Admin on 10.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property(nonatomic, copy) NSString *title, *artist, *album;
@property int playingTime;

-(instancetype) initWithTitle:(NSString *) title Artist:(NSString *) artist Album:(NSString *) album AndPlayingTime:(int) time;
-(BOOL)isEqual:(Song *)song;
@end
