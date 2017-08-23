//
//  DBSetManager.m
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/22.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "DBSetManager.h"

@interface DBSetManager ()

@end

// Constants
// NSString * const DBSetManagerDidSomethingNotification = @"DBSetManagerDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation DBSetManager

#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Default

- (instancetype)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)dealloc {
}

#pragma mark -
#pragma mark Properties

- (FMDTContext *)favorites
{
    return [self cacheWithClass:[Product class] dbPath:[NSString stringWithFormat:@"%@/Documents/favorites.db",NSHomeDirectory()]];
}



#pragma mark -
#pragma mark Public methods

- (FMDTContext *)dynamicTable:(NSString *)name {
    
    /**
     *  设置将对象映射到不同的数据表
     */
    return [self cacheWithClass:[Product class] tableName:name];
}

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
