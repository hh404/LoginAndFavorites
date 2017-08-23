//
//  UserManager.h
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;
#import "HTTPManager.h"

//实际上是鉴权成功通知，为了上传本地的收藏
extern NSString * const UserManagerDidLoggedNotification;

@interface UserManager : NSObject

/**
 创建或者获取临时用户

 @return 返回临时用户对象
 */
+ (UserInfo*)createTempUser;

/**
 从数据获取当前用户信息

 @return 返回当前用户
 */
+ (UserInfo*)userFromDB;

/**
 登录

 @param userName 用户名
 @param password 密码
 */
+ (void)loginWithUserName:(NSString*)userName password:(NSString*)password;

/**
 请求当前鉴权状态，在前后台切换时候请求

 @param email 用户名
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestAppOauthStatus:(NSString*)email success:(httpSuccess)success failure:(httpFailure)failure;

/**
 登出
 */
+ (void)logoutSuccess:(httpSuccess)success failure:(httpFailure)failure;

@end
