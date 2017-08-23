//
//  HTTPManager.m
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "HTTPManager.h"

@interface HTTPManager ()

@end

// Constants
// NSString * const HTTPManagerDidSomethingNotification = @"HTTPManagerDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

static HTTPManager *gHTTPManager = nil;

@implementation HTTPManager

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

#pragma mark -
#pragma mark Public methods

+ (instancetype)shareManager;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gHTTPManager = [[HTTPManager alloc] init];
    });
    return gHTTPManager;
}

+ (void)requestAppOauthStatus:(NSString*)email success:(httpSuccess)success failure:(httpFailure)failure
{
    //成功之后，返回用户名，切换tempUser为正式user
    
}

+ (void)registerWithEmail:(NSString*)email password:(NSString*)password success:(httpSuccess)success failure:(httpFailure)failure
{
    if([HHTools validationEmail:email])
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            int random = arc4random()%5+1;
            if(random == 2)
            {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络错误"                                                                      forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:@"com.hw.LoginAndFavorites" code:NSURLErrorCancelled userInfo:userInfo];
                failure(error);
            }
            else
            {
                HTTPRegisterResponse *response = [[HTTPRegisterResponse alloc] init];
                if(random == 3)
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"注册失败"                                                                      forKey:NSLocalizedDescriptionKey];
                    NSError *error = [NSError errorWithDomain:@"com.hw.LoginAndFavorites" code:-2 userInfo:userInfo];
                    failure(error);
                }
                else
                {
                    NSString *token = [RandomStringHelper generateStringWithLength:32];
                    response.accessToken = token;
                    response.resultCode = 200;
                    response.resultDescription = @"注册成功";
                    success(response);
                }
                
            }
        });
        
    }
    else
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"email无效"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"com.hw.LoginAndFavorites" code:-6 userInfo:userInfo];
        failure(error);
    }
}

+ (void)loginWithEmail:(NSString*)email password:(NSString*)password success:(httpSuccess)success failure:(httpFailure)failure;
{
    if([HHTools validationEmail:email])
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            int random = arc4random()%5+1;
            if(random == 2)
            {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络错误"                                                                      forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:@"com.hw.LoginAndFavorites" code:NSURLErrorCancelled userInfo:userInfo];
                failure(error);
            }
            else
            {
                HTTPLoginResponse *response = [[HTTPLoginResponse alloc] init];
                if(random == 3)
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"登录失败"                                                                      forKey:NSLocalizedDescriptionKey];
                    NSError *error = [NSError errorWithDomain:@"com.hw.LoginAndFavorites" code:-2 userInfo:userInfo];
                    failure(error);
                }
                else
                {
                    NSString *token = [RandomStringHelper generateStringWithLength:32];
                    response.accessToken = token;
                    response.resultCode = 200;
                    response.resultDescription = @"登录成功";
                    success(response);
                }
                
            }
        });
    }
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"email无效"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"com.hw.LoginAndFavorites" code:-6 userInfo:userInfo];
        failure(error);
    }
}

+ (void)uploadFavorites:(NSArray*)favorites success:(httpSuccess)success failure:(httpFailure)failure;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        int random = arc4random()%5+1;
        if(random == 2)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络错误"                                                                      forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"com.hw.LoginAndFavorites" code:NSURLErrorCancelled userInfo:userInfo];
            failure(error);
        }
        else
        {
            HTTPFavoritesResponse *response = [[HTTPFavoritesResponse alloc] init];
            if(random == 3)
            {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"上传失败"                                                                      forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:@"com.hw.LoginAndFavorites" code:-2 userInfo:userInfo];
                failure(error);
            }
            else
            {
                NSMutableArray *serverFavorites = [NSMutableArray array];
                for(int i=0; i<arc4random()%10;i++)
                {
                    Product *fs = [[Product alloc] init];
                    fs.productName = [RandomStringHelper generateStringWithLength:12];
                    fs.productID = [RandomStringHelper generateStringWithLength:6];
                    [serverFavorites addObject:fs];
                }
                [serverFavorites addObjectsFromArray:favorites];
                //假设排序了
                response.favorites = serverFavorites;
                response.resultCode = 200;
                response.resultDescription = @"上传成功";
                success(response);
            }
            
        }
    });
}

+ (void)requestFavorites:(NSString*)userID success:(httpSuccess)success failure:(httpFailure)failure;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        int random = arc4random()%5+1;
        if(random == 2)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络错误"                                                                      forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"com.hw.LoginAndFavorites" code:NSURLErrorCancelled userInfo:userInfo];
            failure(error);
        }
        else
        {
            HTTPFavoritesResponse *response = [[HTTPFavoritesResponse alloc] init];
            if(random == 3)
            {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"获取失败"                                                                      forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:@"com.hw.LoginAndFavorites" code:-2 userInfo:userInfo];
                failure(error);
            }
            else
            {
                NSMutableArray *serverFavorites = [NSMutableArray array];
                for(int i=0; i<arc4random()%10;i++)
                {
                    Product *fs = [[Product alloc] init];
                    fs.productName = [RandomStringHelper generateStringWithLength:12];
                    fs.productID = [RandomStringHelper generateStringWithLength:6];
                    [serverFavorites addObject:fs];
                }

                //假设排序了
                response.favorites = serverFavorites;
                response.resultCode = 200;
                response.resultDescription = @"获取成功";
                success(response);
            }
            
        }
    });
}

+ (void)addFavorites:(Product*)favorite success:(httpSuccess)success failure:(httpFailure)failure
{
    
}

+ (void)logoutSuccess:(httpSuccess)success failure:(httpFailure)failure
{
    HTTPBaseResponse *response = [[HTTPBaseResponse alloc] init];
    response.resultCode = 200;
    response.resultDescription = @"成功";
    success(response);
}

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
