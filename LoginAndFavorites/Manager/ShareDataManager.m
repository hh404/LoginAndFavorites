//
//  ShareDataManager.m
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "ShareDataManager.h"

@interface ShareDataManager ()

@end

// Constants
// NSString * const ShareDataManagerDidSomethingNotification = @"ShareDataManagerDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

static ShareDataManager *gShareDataManager = nil;

@implementation ShareDataManager

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


- (void)setAccessToken:(NSString *)accessToken
{
    _accessToken = accessToken;
    if(_accessToken)
    {
        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kAccessToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark -
#pragma mark Public methods

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gShareDataManager = [[ShareDataManager alloc] init];
    });
    return gShareDataManager;
}

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
