//
//  LTMSystemVersion.m
//  LTM
//
//  Created by 汪潇翔 on 11/11/2016.
//  Copyright © 2016 wangxiaoxiang. All rights reserved.
//

#import "LTMSystemVersion.h"
#import <UIKit/UIDevice.h>
#import "LTMDefines.h"

static NSInteger g_LTMSystemVersionMajor = 0;
static NSInteger g_LTMSystemVersionMinor = 0;
static NSInteger g_LTMSystemVersionBugFix = 0;

@implementation LTMSystemVersion

+ (void)initialize
{
    if (self == [LTMSystemVersion class]) {
        UIDevice *device = [UIDevice currentDevice];
        NSString *version = device.systemVersion;
        
        _LTMDevAssert(version, @"Unable to get version");
        
        NSArray *versionInfo = [version componentsSeparatedByString:@"."];
        NSUInteger length = [versionInfo count];
        _LTMDevAssert(length > 1 && length < 4,
                      @"Unparseable version %@", version);
        
        g_LTMSystemVersionMajor = [[versionInfo objectAtIndex:0] integerValue];
        _LTMDevAssert(g_LTMSystemVersionMajor != 0,
                      @"Unknown version for %@", version);
        
        g_LTMSystemVersionMinor = [[versionInfo objectAtIndex:1] integerValue];
        if (length == 3) {
            g_LTMSystemVersionBugFix = [[versionInfo objectAtIndex:2] integerValue];
        }
    }
}

+ (void)getMajor:(NSInteger*)major minor:(NSInteger*)minor bugFix:(NSInteger*)bugFix {
    if (major) {
        *major = g_LTMSystemVersionMajor;
    }
    if (minor) {
        *minor = g_LTMSystemVersionMinor;
    }
    if (bugFix) {
        *bugFix = g_LTMSystemVersionBugFix;
    }
}

+ (BOOL)isLessThan:(NSInteger )major
{
    return major < g_LTMSystemVersionMajor;
}

+ (BOOL)isLessThanOrEqualTo:(NSInteger )major
{
    return major <= g_LTMSystemVersionMajor;
}

+ (BOOL)isGreaterThan:(NSInteger )major
{
    return g_LTMSystemVersionMajor > major;
}

+ (BOOL)isGreaterThanOrEqualTo:(NSInteger )major
{
    return g_LTMSystemVersionMajor >= major;
}

+ (BOOL)isEqualTo:(NSInteger )major
{
    return g_LTMSystemVersionMajor == major;
}


#if TARGET_OS_IPHONE && TARGET_OS_IOS

+ (BOOL)isGreaterThaniOS7
{
    return [self isGreaterThan:7];
}

+ (BOOL)isGreaterThaniOS8
{
    return [self isGreaterThan:8];
}

+ (BOOL)isGreaterThaniOS9
{
    return [self isGreaterThan:9];
}

+ (BOOL)isGreaterThaniOS10
{
    return [self isGreaterThan:10];
}

#endif

@end
