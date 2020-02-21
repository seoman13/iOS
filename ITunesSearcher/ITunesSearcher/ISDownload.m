//
//  ISDownload.m
//  ITunesSearcher
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ISDownload.h"

@implementation ISDownload

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

@end
