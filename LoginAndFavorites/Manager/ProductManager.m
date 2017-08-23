//
//  ProductManager.m
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/22.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "ProductManager.h"
#import "FMDTUpdateObjectCommand.h"
#import "DBSetManager.h"
#import "FMDTInsertCommand.h"

@interface ProductManager ()

@property (nonatomic,strong)NSMutableArray *favorites;

@end

// Constants
 NSString * const ProductManagerDidUploadNotification = @"ProductManagerDidUploadNotification";
// static NSString * const kSomeLocalConstant = @"SomeValue";

static ProductManager *gFavoritesManager = nil;

@implementation ProductManager

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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Public methods

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gFavoritesManager = [[ProductManager alloc] init];
        [gFavoritesManager _setup];
    });
    return gFavoritesManager;
}

- (void)addFavorite:(Product*)favorite success:(favoritesSuccess)success failure:(httpFailure)failure
{
    if(!favorite)
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"不能为nil"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"com.hw.LoginAndFavorites" code:-2 userInfo:userInfo];
        failure(error);
        return;
    }
    [self.favorites addObject:favorite];
    if([ShareDataManager shareManager].currentUserInfo.isTemp)
    {
        [self _addFavoriteToDB:favorite];
    }
    else
    {
        [HTTPManager addFavorites:favorite success:^(HTTPBaseResponse *response) {
            success(nil);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

- (void)favorites:(favoritesSuccess)success failure:(httpFailure)failure
{
    __weak ProductManager *wkSelf = self;
    if([ShareDataManager shareManager].currentUserInfo.isTemp)
    {
        success(wkSelf.favorites);
    }
    else
    {
        [self _favoritesFromServer:^(NSArray *favorites) {
            success(favorites);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

#pragma mark -
#pragma mark Private methods

- (void)_setup
{
    _favorites = [NSMutableArray array];
    __weak ProductManager *wkSelf = self;
    [self _favoritesFromDB:^(NSArray *favorites) {
        wkSelf.favorites = [favorites mutableCopy];
    } failure:^(NSError *error) {
        
    }];
}

- (void)_didLogged:(NSNotification*)no
{
    //登陆成功，要上传本地的收藏
    //查询数据,并进行排序
    FMDTSelectCommand *cmd = [[DBSetManager shared].favorites createSelectCommand];
    NSString *tempUserID = [[NSUserDefaults standardUserDefaults] objectForKey:kTempUserID];
    [cmd where:@"oprationUserID" equalTo:tempUserID];
    [cmd fetchArrayInBackground:^(NSArray *result) {
        if(result.count > 0)
        {
            [HTTPManager uploadFavorites:result success:^(HTTPBaseResponse *response) {
                //上传成功,删除数据库临时用户产生的收藏,而后，通知界面去重新请求刷新一下数据
                
                FMDTDeleteCommand *dcmd = FMDT_DELETE([DBSetManager shared].favorites);
                //设置条件
                [dcmd where:@"oprationUserID" equalTo:tempUserID];
                //执行删除操作
                [dcmd saveChanges];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:ProductManagerDidUploadNotification object:nil];
                });
            } failure:^(NSError *error) {
                
            }];
        }
    }];
}


/**
 离线或者鉴权失败状态下，需要把收藏存在本地数据库，等登录成功上传
 
 @param favorite 被收藏的产品
 */
- (void)_addFavoriteToDB:(Product*)favorite
{
    if(!favorite.oprationUserID)
    {
        //日志提示
        return;
    }
    //内存缓存
    [_favorites addObject:favorite];
    
    
    //数据库操作
    //创建插入对象
    FMDTInsertCommand *icmd = [[DBSetManager shared].favorites createInsertCommand];
    //添加要插入的对象集合
    [icmd add:favorite];
    //设置添加操作是否使用replace语句
    [icmd setRelpace:YES];
    //执行插入操作
    [icmd saveChangesInBackground:^{
        //数据提交完成
    }];
}


- (void)_favoritesFromServer:(favoritesSuccess)favorites failure:(httpFailure)failure
{
    __weak ProductManager *wkSelf = self;
    [HTTPManager requestFavorites:[ShareDataManager shareManager].currentUserInfo.userID success:^(HTTPBaseResponse *response) {
        HTTPFavoritesResponse *fav = (HTTPFavoritesResponse*)response;
        NSArray *array = fav.favorites;
        //内存缓存
        wkSelf.favorites = [array mutableCopy];
        //更新当前用户的数据,把临时用户的数据库都删了
        favorites(array);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)_favoritesFromDB:(favoritesSuccess)favorites failure:(httpFailure)failure
{
    //查询数据,并进行排序
    FMDTSelectCommand *cmd = [[DBSetManager shared].favorites createSelectCommand];
    
    [cmd where:@"oprationUserID" equalTo:[ShareDataManager shareManager].currentUserInfo.userID];
    [cmd fetchArrayInBackground:^(NSArray *result) {
        favorites(result);
    }];
}

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
