//
//  LTMHex.m
//  LTMToolbox
//
//  Created by user on 16/8/1.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import "LTMHex.h"
#import "LTMStringEncoding.h"

static LTMStringEncoding *g_hexStringEncoder = nil;

@implementation LTMHex

+ (void)initialize
{
    if (self == [LTMHex class]) {
        g_hexStringEncoder = [LTMStringEncoding hexStringEncoding];
    }
}

+ (NSString *)encode:(NSData *)inData {
    return [g_hexStringEncoder encode:inData];
}

+ (NSData *)decode:(NSString *)inString {
    return [g_hexStringEncoder decode:inString];
}

@end
