//
//  AppDelegate+UnitTest.m
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/23.
//  Copyright © 2017年 huangjianwu. All rights reserved.
//

#import "AppDelegate+UnitTest.h"

@implementation AppDelegate (UnitTest)

- (void)initUserAndOauthTest{
    [ShareDataManager shareManager].accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken];
    
    [ShareDataManager shareManager].currentUserInfo = [UserManager userFromDB];
}

@end
