//
//  HTTPBaseResponse.h
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

@interface HTTPBaseResponse : NSObject

@property (nonatomic,assign)NSInteger resultCode;

@property (nonatomic,copy)NSString *resultDescription;

@end
