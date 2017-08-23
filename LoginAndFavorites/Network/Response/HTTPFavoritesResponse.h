//
//  HTTPFavoritesResponse.h
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;
#import "HTTPBaseResponse.h"

@interface HTTPFavoritesResponse : HTTPBaseResponse

@property (nonatomic,strong)NSArray *favorites;

@end
