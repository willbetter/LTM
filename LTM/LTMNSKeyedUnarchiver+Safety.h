//
//  NSKeyedArchiver+LTMSafety.h
//  LTM
//
//  Created by wangxiaoxiang on 16/8/22.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSKeyedUnarchiver (LTMNSKeyedUnarchiverSafetyAddtions)

+ (id)ltm_unarchiveObjectWithData:(NSData *)data error:(NSError *__autoreleasing *)error;

+ (id)ltm_unarchiveObjectWithFile:(NSString *)path error:(NSError *__autoreleasing *)error;

@end

