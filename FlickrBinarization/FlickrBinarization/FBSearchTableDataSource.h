//
//  FBSearchTableDataSource.h
//  FlickrBinarization
//
//  Created by Admin on 17.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FBSearchViewController;

@interface FBSearchTableDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithFBSearchViewController:(FBSearchViewController *)pictureTableViewController;

@end
