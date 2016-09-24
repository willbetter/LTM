//
//  LTMBase64.m
//  LTMToolbox
//
//  Created by user on 16/8/1.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import "LTMBase64.h"
#import "LTMStringEncoding.h"

static LTMStringEncoding *g_base64Coder = nil;
static LTMStringEncoding *g_webSafeBase64Coder = nil;

@implementation LTMBase64

+ (void)initialize
{
    if (self == [LTMBase64 class]) {
        g_base64Coder = [LTMStringEncoding base64StringEncoding];
    }
}

+ (NSData *)decodeAsData:(NSString *)string {
    return [g_base64Coder decode:string];
}

+ (NSString *)dacodeAsString:(NSString *)string {
    return [g_base64Coder stringByDecoding:string];
}

+ (NSString *)encodeData:(NSData *)data {
    return [g_base64Coder encode:data];
}

+ (NSString *)encodeString:(NSString *)string {
    return [g_base64Coder encodeString:string];
}

@end


@implementation LTMWebSafeBase64

+ (void)initialize
{
    if (self == [LTMBase64 class]) {
        g_webSafeBase64Coder = [LTMStringEncoding base64WebsafeStringEncoding];
    }
}

+ (NSData *)decodeAsData:(NSString *)string {
    return [g_webSafeBase64Coder decode:string];
}

+ (NSString *)dacodeAsString:(NSString *)string {
    return [g_webSafeBase64Coder stringByDecoding:string];
}

+ (NSString *)encodeData:(NSData *)data {
    return [g_webSafeBase64Coder encode:data];
}

+ (NSString *)encodeString:(NSString *)string {
    return [g_webSafeBase64Coder encodeString:string];
}


@end
