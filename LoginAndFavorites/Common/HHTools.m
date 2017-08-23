//
//  HHTools.m
//  LoginAndFavorites
//
//  Created by huangjianwu on 2017/8/22.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "HHTools.h"

@interface HHTools ()

@end

// Constants
// NSString * const HHToolsDidSomethingNotification = @"HHToolsDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation HHTools

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

+ (BOOL)validationEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if( [emailTest evaluateWithObject:email]){
        return  YES;
    }else{
        
        return NO;
    }
}

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
