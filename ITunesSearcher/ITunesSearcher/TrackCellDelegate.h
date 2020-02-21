//
//  TrackCellDelegate.h
//  ITunesSearcher
//
//  Created by Admin on 14.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISTrackCell.h"
@class ISSearchViewController;

@interface TrackCellDelegate : NSObject <ISTrackCellDelegate>

- (instancetype)initWithSearchViewController:(ISSearchViewController *)searchViewController;

@end
