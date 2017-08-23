//
//  HTTPRegisterResponse.h
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;
#import "HTTPBaseResponse.h"

@interface HTTPRegisterResponse : HTTPBaseResponse

@property (nonatomic,copy)NSString *accessToken;

@end
