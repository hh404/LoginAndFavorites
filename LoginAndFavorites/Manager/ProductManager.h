//
//  ProductManager.h
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/22.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

extern NSString * const ProductManagerDidUploadNotification;

typedef void(^favoritesSuccess)(NSArray *favorites);

@interface ProductManager : NSObject

+ (instancetype)shareManager;

/**
 添加收藏，内部实现了数放在本地还是网络请求

 @param favorite 要收藏的产品
 */
- (void)addFavorite:(Product*)favorite success:(favoritesSuccess)success failure:(httpFailure)failure;

/**
 获取收藏的产品

 @param favorites 成功回调
 @param failure 失败回调
 */
- (void)favorites:(favoritesSuccess)favorites failure:(httpFailure)failure;

@end
