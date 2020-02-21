//
//  FBSearchTableDataSource.m
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "FBSearchTableDataSource.h"
#import "FBSearchViewController.h"
#import "FBPictureCell.h"
#import "FBImageItem.h"
#import "ImageSetter.h"
#import "FBImageLoader.h"
#import "FBImageFilter.h"

@interface FBSearchTableDataSource ()

@property (nonatomic, weak) FBSearchViewController *searchViewController;

@end

@implementation FBSearchTableDataSource

- (instancetype)initWithFBSearchViewController:(FBSearchViewController *)searchViewController {
    self = [super init];
    if (self) {
        self.searchViewController = searchViewController;
    }
    return self;
}

#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return [[self.searchViewController.fetchedResultsController sections] count];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray *sections = [self.searchViewController.fetchedResultsController sections];
//    id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
//    return [sectionInfo numberOfObjects];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.searchViewController.fetchedResultsController.fetchedObjects count];
    NSArray *sections = [[self.searchViewController fetchedResultsController] sections];
    id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
//    return [self.searchViewController.searchResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FBPictureCell *cell = (FBPictureCell *)[tableView dequeueReusableCellWithIdentifier:pictureCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[FBPictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pictureCellIdentifier];
    }
    // Set cell's image to nil
    ((FBPictureCell *)cell).myImageView.image = nil;
    
    // Set cell's delegate
    ((FBPictureCell *)cell).delegate = self.searchViewController.pictureCellDelegate;
    NSArray <FBImageItem *> *imageItems = self.searchViewController.fetchedResultsController.fetchedObjects;
    FBImageItem *imageItem = imageItems[indexPath.row];
//    NSMutableArray *imageItems = self.searchViewController.searchResults;
//    NSDictionary *imageItem = imageItems[indexPath.row];
//    cell.urlString = imageItem[@"urlString"];
    cell.urlString = imageItem.urlString;
    
    if (![self.searchViewController.colorfulPicturesCache objectForKey:imageItem.urlString]) {
        ((FBPictureCell *)cell).binarizationButton.hidden = YES;
    } else {
        ((FBPictureCell *)cell).binarizationButton.hidden = NO;
    }
    
//    NSNumber * _Nullable state = [self.searchViewController.buttonStates valueForKey:imageItem[@"urlString"]];
    NSNumber * _Nullable state = [self.searchViewController.buttonStates valueForKey:imageItem.urlString];
    
    // Check which picture we should show and then show it
    if (state == nil || [state isEqualToNumber:@NO]) {
//        [ImageSetter setColorfulImage:imageItem[@"urlString"]  inSearchViewController:self.searchViewController forCell:cell atIndexPath:indexPath];
//        [self.searchViewController.buttonStates setValue:@NO forKey:imageItem[@"urlString"]];
        [ImageSetter setColorfulImage:imageItem.urlString inSearchViewController:self.searchViewController forCell:cell atIndexPath:indexPath];
        [self.searchViewController.buttonStates setValue:@NO forKey:imageItem.urlString];
        // Set button's color
        cell.binarizationButton.backgroundColor = [UIColor grayColor];
    } else {
//        [ImageSetter setBinarizedImage:imageItem[@"urlString"] inSearchViewController:self.searchViewController forCell:cell atIndexPath:indexPath];
//        [self.searchViewController.buttonStates setValue:@YES forKey:imageItem[@"urlString"]];
        [ImageSetter setBinarizedImage:imageItem.urlString inSearchViewController:self.searchViewController forCell:cell atIndexPath:indexPath];
        [self.searchViewController.buttonStates setValue:@YES forKey:imageItem.urlString];
        // Set button's color
        cell.binarizationButton.backgroundColor = [UIColor cyanColor];
    }
    
    return cell;
}

@end
