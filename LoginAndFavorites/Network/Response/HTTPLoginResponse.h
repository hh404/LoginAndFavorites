//
//  HTTPLoginResponse.h
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;
#import "HTTPBaseResponse.h"

@interface HTTPLoginResponse : HTTPBaseResponse

@property (nonatomic,copy)NSString *accessToken;

@property (nonatomic,strong)UserInfo *userInfo;

@end
