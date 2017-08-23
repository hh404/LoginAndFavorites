//
//  ProductManagerTests.m
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/23.
//  Copyright © 2017年 huangjianwu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProductManager.h"
#import "AppDelegate+UnitTest.h"

@interface ProductManagerTests : XCTestCase

@end

@implementation ProductManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testAddFavoriteWithNil{
    
    XCTestExpectation* expectation = [self expectationWithDescription:@"xx"];
        [[ProductManager shareManager] addFavorite:nil success:^(NSArray *favorites) {
            [expectation fulfill];
        } failure:^(NSError *error) {
            XCTAssert(error, @"失败");
            [expectation fulfill];
        }];

    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        
    }];

}

- (void)testAddFavoriteWithProductNoLogin
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate initUserAndOauthTest];
    Product *product = [[Product alloc] init];
    product.productName = @"iPhone8";
    product.productID = @"10000";
    //product.oprationUserID
    XCTestExpectation* expectation = [self expectationWithDescription:@"xx"];
    [[ProductManager shareManager] addFavorite:nil success:^(NSArray *favorites) {
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTAssert(error, @"失败");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
