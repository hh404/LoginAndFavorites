//
//  UserManager.m
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "UserManager.h"

@interface UserManager ()

@end

// Constants
 NSString * const UserManagerDidLoggedNotification = @"UserManagerDidLoggedNotification";
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation UserManager

#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Default

- (instancetype)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)dealloc {
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Public methods

+ (UserInfo*)createTempUser
{
    UserInfo *user = [[UserInfo alloc] init];
    NSString *tUserID = [[NSUserDefaults standardUserDefaults] objectForKey:kTempUserID];
    if(!tUserID)
    {
        user.userID = [RandomStringHelper generateStringWithLength:32];
    }
    else
    {
        user.userID = tUserID;
    }
    user.isTemp = YES;
    return user;
}
+ (UserInfo*)userFromDB
{
    NSUserDefaults *userDefault =[NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefault objectForKey:kUserID];
    if(userID)
    {
        UserInfo *user = [[UserInfo alloc] init];
        
        user.userID = [userDefault objectForKey:kUserID];
        user.userName = [userDefault objectForKey:kUserName];
        user.isTemp = YES;
        return user;
    }
    else
    {
        return [UserManager createTempUser];
    }
    
}

+ (void)requestAppOauthStatus:(NSString*)email success:(httpSuccess)success failure:(httpFailure)failure
{
    [HTTPManager requestAppOauthStatus:email success:^(HTTPBaseResponse *response) {
        HTTPLoginResponse *loginResponse = (HTTPLoginResponse*)response;
        if(loginResponse.resultCode != 200)
        {
            [ShareDataManager shareManager].currentUserInfo = [UserManager createTempUser];
        }
        else
        {
            [ShareDataManager shareManager].currentUserInfo = loginResponse.userInfo;
            //oauth成功之后，发通知上传本地
            [ShareDataManager shareManager].isLogged = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:UserManagerDidLoggedNotification object:nil];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

+ (void)loginWithUserName:(NSString*)userName password:(NSString*)password
{
    [HTTPManager loginWithEmail:userName password:password success:^(HTTPBaseResponse *response) {
        HTTPLoginResponse *loginResponse = (HTTPLoginResponse*)response;
        [ShareDataManager shareManager].accessToken = loginResponse.accessToken;
        [ShareDataManager shareManager].currentUserInfo = loginResponse.userInfo;
        [ShareDataManager shareManager].isLogged = YES;
        [[NSUserDefaults standardUserDefaults] setObject:loginResponse.userInfo.userName forKey:kUserName];
        [[NSUserDefaults standardUserDefaults] setObject:loginResponse.userInfo.userID forKey:kUserID];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:UserManagerDidLoggedNotification object:nil];
        
    } failure:^(NSError *error) {
        
    }];
}

+ (void)logoutSuccess:(httpSuccess)success failure:(httpFailure)failure
{
    [HTTPManager logoutSuccess:^(HTTPBaseResponse *response) {
        if(response.resultCode == 200)
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserName];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [ShareDataManager shareManager].isLogged = NO;
        }
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
