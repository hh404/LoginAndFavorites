//
//  DBSetManager.h
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/22.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;
#import "FMDTManager.h"

@interface DBSetManager : FMDTManager

@property (nonatomic, strong, readonly) FMDTContext *favorites;

- (FMDTContext *)dynamicTable:(NSString *)name;

@end
