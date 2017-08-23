//
//  UserManagerTests.m
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/23.
//  Copyright © 2017年 huangjianwu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate+UnitTest.h"
#import <OCMock/OCMock.h>

@interface UserManagerTests : XCTestCase

@end

@implementation UserManagerTests

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

- (void)testCreateTempUser{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    //创建成功了
    [appDelegate initUserAndOauthTest];
    XCTAssertNotNil([ShareDataManager shareManager].currentUserInfo);
    //必须32位
    XCTAssertTrue([[ShareDataManager shareManager].currentUserInfo.userID length] == 32);
    //验证临时用户标识
    XCTAssertTrue([ShareDataManager shareManager].currentUserInfo.isTemp);
}

/**
 只有登录成功过之后，才能从db获取到当前用户
 */
- (void)testUserFromDBWithTempUser{

    UserInfo *userInfo = [UserManager userFromDB];
    //返回临时用户或者上次登录的用户
    //XCTAssertNotNil(userInfo);
   // XCTAssertNotNil(userInfo.userName);
}

/**
 登出会清空
 */
- (void)testLogout
{
    XCTestExpectation* expectation = [self expectationWithDescription:@"xx"];
    [UserManager logoutSuccess:^(HTTPBaseResponse *response) {
        //返回正常是200
        XCTAssertTrue(response.resultCode == 200);
        //登录状态已经重置
        XCTAssertTrue(![ShareDataManager shareManager].isLogged);
        //存储的用户名
        XCTAssertTrue(![[NSUserDefaults standardUserDefaults] objectForKey:kUserName]);
        //存储的用户ID
        XCTAssertTrue(![[NSUserDefaults standardUserDefaults] objectForKey:kUserID]);
        [expectation fulfill];
    } failure:^(NSError *error) {
        [expectation fulfill];
    }];

    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        
    }];
}

- (void)testLogin
{
    [UserManager loginWithUserName:@"username" password:@"password"];
//
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
