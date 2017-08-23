//
//  UserInfo.h
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

@interface UserInfo : NSObject

@property(nonatomic,copy)NSString *userName;

@property(nonatomic,copy)NSString *userID;

@property(nonatomic,assign)BOOL isTemp;

@end
