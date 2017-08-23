//
//  Product.h
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/21.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;
#import "FMDTObject.h"

@interface Product : FMDTObject

@property (nonatomic,copy)NSString *productID;

@property (nonatomic,copy)NSString *productName;

@property (nonatomic,strong)NSNumber *oprationTime;

@property (nonatomic,copy)NSString *oprationUserID;

@end
