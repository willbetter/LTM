//
//  NSKeyedArchiver+LTMSafety.m
//  LTM
//
//  Created by wangxiaoxiang on 16/8/22.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import "LTMNSKeyedUnarchiver+Safety.h"

NSString * const LTMNSKeyedUnarchiverSafetyErrorDomain = @"com.youku.laifeng.ltm.keyed_unarchiver_safety.error";

@implementation NSKeyedUnarchiver (LTMNSKeyedUnarchiverSafetyAddtions)


+ (id)ltm_unarchiveObjectWithData:(NSData *)data error:(NSError *__autoreleasing *)error {
    id object = nil;
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *exception){
#if DEBUG
        @throw exception;
#endif
        if (error != NULL) {
            *error = [NSError errorWithDomain:LTMNSKeyedUnarchiverSafetyErrorDomain code:-1 userInfo:exception.userInfo];
        }
    }
    @finally{
        return object;
    }
}

+ (id)ltm_unarchiveObjectWithFile:(NSString *)path error:(NSError *__autoreleasing *)error{
    id object = nil;
    
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    @catch (NSException *exception) {
#if DEBUG
        @throw exception;
#endif
        if (error != NULL) {
            *error = [NSError errorWithDomain:LTMNSKeyedUnarchiverSafetyErrorDomain code:-1 userInfo:exception.userInfo];
        }
    }
    @finally {
        return object;
    }
}
@end
