//
//  ShareDataManager.h
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

@interface ShareDataManager : NSObject

@property (nonatomic,strong)UserInfo *currentUserInfo;

@property (nonatomic,strong)NSString *accessToken;

@property (nonatomic,assign)BOOL isLogged;

+ (instancetype)shareManager;

@end
