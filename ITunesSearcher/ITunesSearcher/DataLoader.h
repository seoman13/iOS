//
//  DataLoader.h
//  ITunesSearcher
//
//  Created by Admin on 16.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ISSearchViewController;

@interface DataLoader : NSObject

+ (void)loadDataByTerm:(NSString *)term intoSearchViewController:(ISSearchViewController *)searchViewController;

@end
