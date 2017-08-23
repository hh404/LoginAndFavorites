//
//  HTTPManager.h
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

typedef void(^httpSuccess)(HTTPBaseResponse *response);
typedef void(^httpFailure)(NSError *error);

@interface HTTPManager : NSObject

+ (instancetype)shareManager;


/**
 获取当前app是否是登录状态,也就是token是否有效

 @param email 用户名
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestAppOauthStatus:(NSString*)email success:(httpSuccess)success failure:(httpFailure)failure;


/**
 注册

 @param email 注册用户名
 @param password 注册密码
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)registerWithEmail:(NSString*)email password:(NSString*)password success:(httpSuccess)success failure:(httpFailure)failure;

/**
 登录
 
 @param email 注册用户名
 @param password 注册密码
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)loginWithEmail:(NSString*)email password:(NSString*)password success:(httpSuccess)success failure:(httpFailure)failure;


/**
 上传本地的收藏

 @param favorites 本地缓存的
 @param success 成功的block,返回最新的列表
 @param failure 失败的block
 */
+ (void)uploadFavorites:(NSArray*)favorites success:(httpSuccess)success failure:(httpFailure)failure;


/**
 请求收藏列表

 @param userID 当前用户ID
 @param success 成功的block,返回状态
 @param failure 失败
 */
+ (void)requestFavorites:(NSString*)userID success:(httpSuccess)success failure:(httpFailure)failure;


/**
 添加收藏请求

 @param favorite 要收藏的产品
 @param success 收藏成功或失败回调
 @param failure 网络清楚错误回调
 */
+ (void)addFavorites:(Product*)favorite success:(httpSuccess)success failure:(httpFailure)failure;

/**
 登出

 @param success 成功
 @param failure 失败
 */
+ (void)logoutSuccess:(httpSuccess)success failure:(httpFailure)failure;

@end
