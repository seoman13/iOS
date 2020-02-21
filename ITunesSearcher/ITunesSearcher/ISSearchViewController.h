//
//  ISSearchViewController.h
//  ITunesSearcher
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISTrackCell.h"
@class ISTrack;
@class ISDownload;
@class TrackCellDelegate;
@class ArtworkCache;


@interface ISSearchViewController : UIViewController

// Visual Elements
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

// For keeping data
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) NSMutableArray <ISTrack *> *searchResults;
@property (nonatomic, strong) NSURLSession *defaultSession;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSMutableDictionary <NSString *, ISDownload *> *activeDownloads;
@property (nonatomic, strong) NSURLSession *downloadsSession;
@property (nonatomic, strong) NSMutableDictionary <NSString*, UIImage*> *cachedArtwork;
//@property (nonatomic, strong) NSCache *cachedArtwork;

// Cell Delegate
@property (nonatomic, strong) id<ISTrackCellDelegate> trackCellDelegate;

- (void)dismissKeyboard;
- (void)updateSearchResults:(NSData *)data;

// Methods for when download buttons tapped
- (void)startDownload:(ISTrack *)track;
- (void)pauseDownload:(ISTrack *)track;
- (void)cancelDownload:(ISTrack *)track;
- (void)resumeDownload:(ISTrack *)track;
- (void)playDownload:(ISTrack *)track;

@end
