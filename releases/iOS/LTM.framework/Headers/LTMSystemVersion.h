//
//  LTMSystemVersion.h
//  LTM
//
//  Created by 汪潇翔 on 11/11/2016.
//  Copyright © 2016 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LTMSystemVersion : NSObject

+ (void)getMajor:(NSInteger *)major minor:(NSInteger *)minor bugFix:(NSInteger *)bugFix;

+ (BOOL)isLessThan:(NSInteger )major;

+ (BOOL)isLessThanOrEqualTo:(NSInteger )major;

+ (BOOL)isGreaterThan:(NSInteger )major;

+ (BOOL)isGreaterThanOrEqualTo:(NSInteger )major;

+ (BOOL)isEqualTo:(NSInteger )major;

#if TARGET_OS_IPHONE && TARGET_OS_IOS

+ (BOOL)isGreaterThaniOS7;

+ (BOOL)isGreaterThaniOS8;

+ (BOOL)isGreaterThaniOS9;

+ (BOOL)isGreaterThaniOS10;

#endif

@end
