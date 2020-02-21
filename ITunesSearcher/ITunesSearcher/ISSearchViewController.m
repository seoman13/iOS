//
//  ISSearchViewController.m
//  ITunesSearcher
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ISSearchViewController.h"
#import "SearchBarDelegate.h"
#import "SearchTableDelegate.h"
#import "SearchTableDataSource.h"
#import "UrlSessionDownloadDelegate.h"
#import "DownloadButtonsDelegate.h"
#import "DataParser.h"
#import "TrackCellDelegate.h"

@interface ISSearchViewController ()

// Delegates for this view
@property (nonatomic, strong) SearchBarDelegate *searchBarDelegate;
@property (nonatomic, strong) SearchTableDelegate *searchTableDelegate;
@property (nonatomic, strong) SearchTableDataSource *searchTableDataSource;
@property (nonatomic, strong) UrlSessionDownloadDelegate *urlSessionDownloadDelegate;
@property (nonatomic, strong) DownloadButtonsDelegate *downloadButtonsDelegate;

@end

@implementation ISSearchViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        [self initializeContainers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Setup SearchBar and its Delegate
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBarDelegate = [[SearchBarDelegate alloc] initWithSearchViewController:self];
    self.searchBar.placeholder = @"Song name or artist";
    self.searchBar.delegate = self.searchBarDelegate;
    self.navigationItem.titleView = self.searchBar;
    self.navigationController.navigationBar.translucent = NO;
    
    // Setup TableView with its Delegate and DataSource
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.searchTableDelegate = [[SearchTableDelegate alloc] initWithSearchViewController:self];
    self.tableView.delegate = self.searchTableDelegate;
    self.searchTableDataSource = [[SearchTableDataSource alloc] initWithSearchViewController:self];
    self.tableView.dataSource = self.searchTableDataSource;
    [self.tableView registerClass:[ISTrackCell class] forCellReuseIdentifier:trackCellIdentifier];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialize containers and urlSessionDownloadTaskDelegate
- (void)initializeContainers {
    self.searchResults = [[NSMutableArray alloc] init];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    // Session, task, sessionDelegate
    self.defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    self.defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"bgSessionConfiguration"]];
    self.urlSessionDownloadDelegate = [[UrlSessionDownloadDelegate alloc] initWithSearchViewController:self];
    self.downloadsSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self.urlSessionDownloadDelegate delegateQueue:nil];
    self.activeDownloads = [[NSMutableDictionary alloc] init];
    // Cell delegate
    self.trackCellDelegate = [[TrackCellDelegate alloc] initWithSearchViewController:self];
    // Download Buttons Delegate
    self.downloadButtonsDelegate = [[DownloadButtonsDelegate alloc] initWithSearchViewController:self];
    // Cached artwork
//    self.cachedArtwork = [NSCache new];
    self.cachedArtwork = [NSMutableDictionary new];
}

#pragma mark - Keyboard Dismissal
- (void)dismissKeyboard {
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
}

#pragma mark - Update Search Results
- (void)updateSearchResults:(NSData *)data {
    [DataParser updateSearchResult:data forSearchViewController:self];
}

#pragma mark Download methods

// Called when the Download button for a track is tapped
- (void)startDownload:(ISTrack *)track {
    [self.downloadButtonsDelegate startDownload:track];
}

// Called when the Pause button for a track is tapped
- (void)pauseDownload:(ISTrack *)track {
    [self.downloadButtonsDelegate pauseDownload:track];
}

// Called when the Cancel button for a track is tapped
- (void)cancelDownload:(ISTrack *)track {
    [self.downloadButtonsDelegate cancelDownload:track];
}

// Called when the Resume button for a track is tapped
- (void)resumeDownload:(ISTrack *)track {
    [self.downloadButtonsDelegate resumeDownload:track];
}

// Play Download of the selected cell
- (void)playDownload:(ISTrack *)track {
    [self.downloadButtonsDelegate playDownload:track];
}

@end
