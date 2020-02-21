//
//  FBCollectionViewDelegate.m
//  FlickrBrowser
//
//  Created by Admin on 23.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "FBCollectionViewDelegate.h"
#import "FBSearchPanelViewController.h"
#import "FBPostViewController.h"
#import "FBPictureItem.h"
#import "FBPictureCell.h"
#import "FBImageSetter.h"
#import "FBImageLoader.h"
#import "FBDataLoaderFromFlickr.h"

NSInteger const itemsPerRow = 3;

@interface FBCollectionViewDelegate ()

@property (weak, nonatomic) FBSearchPanelViewController *searchPanelViewController;

@end

@implementation FBCollectionViewDelegate

#pragma mark - Initialization
- (instancetype)initWithSearchPanelViewController:(FBSearchPanelViewController *)searchPanelViewController {
    self = [super init];
    if (self) {
        _searchPanelViewController = searchPanelViewController;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.searchPanelViewController.fetchedResultsController.fetchedObjects count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FBPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pictureCellIdentifier" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[FBPictureCell alloc] init];
    }
    ((FBPictureCell *)cell).imageView.image = nil;
    
    NSArray <FBPictureItem *> *pictureItems = self.searchPanelViewController.fetchedResultsController.fetchedObjects;
    FBPictureItem *pictureItem = pictureItems[indexPath.row];
    FBPictureCellSize cellSize = [self getPictureCellSizeForPictureItem:pictureItem];
    cell.size = cellSize;
    [cell.activityIndicator startAnimating];
    FBImageSetter *imageSetter = [[FBImageSetter alloc] init];
    [imageSetter setImageFromAddress:pictureItem.pictureUrlString desiredSize:FBPictureItemImageSizeSmall forImageView:cell.imageView handler:^{
        [cell.activityIndicator stopAnimating];
        [collectionView reloadData];
    }];
    
    return cell;
}

- (FBPictureCellSize)getPictureCellSizeForPictureItem:(FBPictureItem *)pictureItem {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *views = [formatter numberFromString:pictureItem.views];
    if ([views unsignedIntegerValue] > 200000) {
        return FBPictureCellSizeMedium;
    }
    return FBPictureCellSizeSmall;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FBPostViewController *vc = [[FBPostViewController alloc] init];
    NSArray <FBPictureItem *> *imageItems = self.searchPanelViewController.fetchedResultsController.fetchedObjects;
    FBPictureItem *pictureItem = imageItems[indexPath.row];
    [self.searchPanelViewController.navigationController pushViewController:vc animated:YES];
    [vc setupPostViewWithPictureItem:pictureItem];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    if ([self.searchPanelViewController.fetchedResultsController.fetchedObjects count] - 3 == indexPath.row) {
//        NSInteger page = [self.searchPanelViewController.fetchedResultsController.fetchedObjects count] / 20 + 1;
//        [FBDataLoaderFromFlickr searchForPicturesByTerm:self.searchPanelViewController.searchBar.text andPage:page inSearchPanelViewController:self.searchPanelViewController];
//    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat widthPerItem = [self calculateCellWidth];
    NSArray <FBPictureItem *> *imageItems = self.searchPanelViewController.fetchedResultsController.fetchedObjects;
    FBPictureItem *pictureItem = imageItems[indexPath.row];
    FBPictureCellSize size = [self getPictureCellSizeForPictureItem:pictureItem];
    CGFloat width = 0;
    CGFloat height = 0;
    switch (size) {
        case FBPictureCellSizeSmall:
            width = widthPerItem;
            height = widthPerItem;
            break;
        case FBPictureCellSizeMedium:
            width = 2 * widthPerItem + 1;
            height = 2 * widthPerItem + 1;
            break;
    }
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

#pragma mark - FlowLayout helping Functions
- (CGFloat)calculateCellWidth {
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat padding = 1 * (1 + itemsPerRow);
    CGFloat availableWidth = screenWidth - padding;
    CGFloat widthPerItem = availableWidth / itemsPerRow;
    
    return widthPerItem;
}

@end
