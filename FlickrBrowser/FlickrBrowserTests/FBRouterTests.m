//
//  FBRouterTests.m
//  FlickrBrowser
//
//  Created by Admin on 25.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FBRouter.h"

@interface FBRouterTests : XCTestCase

@end

@implementation FBRouterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPhotosSearchRequest {
    NSString *query = @"Cat";
    NSInteger page = 2;
    NSURLRequest *request = [FBRouter newPicturesSearchRequestWithQuery:query atPage:page];
    NSString *url = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=caad36f46cb06f7b32c7ea69457cc7f9&content_type=1&sort=relevance&text=Cat&per_page=20&page=2&extras=owner_name,geo&format=json&nojsoncallback=1";
    XCTAssertTrue([request.URL.absoluteString isEqualToString:url], @"Urls differ");
}

- (void)testPictureInfoRequest {
    NSString *pictureId = @"14410052054";
    NSString *url = @"https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=caad36f46cb06f7b32c7ea69457cc7f9&photo_id=14410052054&format=json&nojsoncallback=1";
    NSURLRequest *request = [FBRouter pictureInfoRequestWithPictureId:pictureId];
    XCTAssertTrue([request.URL.absoluteString isEqualToString:url], @"Urls differ");
}

- (void)testPictureNumberOfFavoritesRequest {
    NSString *pictureId = @"14410052054";
    NSString *url = @"https://api.flickr.com/services/rest/?method=flickr.photos.getFavorites&api_key=caad36f46cb06f7b32c7ea69457cc7f9&photo_id=14410052054&page=1&format=json&nojsoncallback=1";
    NSURLRequest *request = [FBRouter pictureNumberOfFavoritesRequestWithPictureId:pictureId];
    XCTAssertTrue([request.URL.absoluteString isEqualToString:url], @"Urls differ");
}

- (void)testListOfCommentsRequest {
    NSString *pictureId = @"14410052054";
    NSString *url = @"https://api.flickr.com/services/rest/?method=flickr.photos.comments.getList&api_key=caad36f46cb06f7b32c7ea69457cc7f9&photo_id=14410052054&format=json&nojsoncallback=1";
    NSURLRequest *request = [FBRouter pictureCommentsRequestWithPictureId:pictureId];
    XCTAssertTrue([request.URL.absoluteString isEqualToString:url], @"Urls differ");
}

- (void)testUserInfoRequest {
    NSString *user_id = @"79766186@N04";
    NSString *url = @"https://api.flickr.com/services/rest/?method=flickr.people.getInfo&api_key=caad36f46cb06f7b32c7ea69457cc7f9&user_id=79766186@N04&format=json&nojsoncallback=1";
    NSURLRequest *request = [FBRouter userInfoRequestWithUserId:user_id];
    XCTAssertTrue([request.URL.absoluteString isEqualToString:url], @"Urls differ. URL From Method: %@", url);
}

- (void)testPlaceInfoRequest {
    NSString *placeId = @"QqUrSrdTWr2xNrWqXA";
    NSString *url = @"https://api.flickr.com/services/rest/?method=flickr.places.getInfo&api_key=caad36f46cb06f7b32c7ea69457cc7f9&place_id=QqUrSrdTWr2xNrWqXA&format=json&nojsoncallback=1";
    NSURLRequest *request = [FBRouter placeInfoRequestWithPlaceId:placeId];
    XCTAssertTrue([request.URL.absoluteString isEqualToString:url], @"Urls differ");
}

@end
