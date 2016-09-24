//
//  LTMDigest.m
//  LTM
//
//  Created by wangxiaoxiang on 16/8/22.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import "LTMDigest.h"
#import <CommonCrypto/CommonDigest.h>
#import "LTMHex.h"

@implementation LTMDigest


#pragma mark -
#pragma mark - MD

+ (NSData *)MD2:(NSData *)inData {
    unsigned char hash[CC_MD2_DIGEST_LENGTH];
    (void) CC_MD2( [inData bytes], (CC_LONG)[inData length], hash );
    return ( [NSData dataWithBytes: hash length: CC_MD2_DIGEST_LENGTH] );
}

+ (NSString *)MD2AsString:(NSString *)inString {
    NSData *inData = [inString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *digestData = [[self class] MD2:inData];
    NSString *outString = [LTMHex encode:digestData];
    return outString;
}

+ (NSData *)MD4:(NSData *)inData {
    unsigned char hash[CC_MD4_DIGEST_LENGTH];
    (void) CC_MD4( [inData bytes], (CC_LONG)[inData length], hash );
    return ( [NSData dataWithBytes: hash length: CC_MD4_DIGEST_LENGTH] );
}

+ (NSString *)MD4AsString:(NSString *)inString {
    NSData *inData = [inString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *digestData = [[self class] MD4:inData];
    NSString *outString = [LTMHex encode:digestData];
    return outString;
}

+ (NSData *)MD5:(NSData *)inData {
    unsigned char hash[CC_MD5_DIGEST_LENGTH];
    (void) CC_MD5( [inData bytes], (CC_LONG)[inData length], hash );
    return ( [NSData dataWithBytes: hash length: CC_MD5_DIGEST_LENGTH] );
}

+ (NSString *)MD5AsString:(NSString *)inString {
    NSData *inData = [inString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *digestData = [[self class] MD5:inData];
    NSString *outString = [LTMHex encode:digestData];
    return outString;
}

#pragma mark -
#pragma mark - SHA

+ (NSData *)SHA1:(NSData *)inData {
    unsigned char hash[CC_SHA1_DIGEST_LENGTH];
    (void) CC_SHA1( [inData bytes], (CC_LONG)[inData length], hash );
    return ( [NSData dataWithBytes: hash length: CC_SHA1_DIGEST_LENGTH] );
}

+ (NSString *)SHA1AsString:(NSString *)inString {
    NSData *inData = [inString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *digestData = [[self class] SHA1:inData];
    NSString *outString = [LTMHex encode:digestData];
    return outString;
}

+ (NSData *)SHA224:(NSData *)inData {
    unsigned char hash[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224( [inData bytes], (CC_LONG)[inData length], hash );
    return [NSData dataWithBytes: hash length: CC_SHA224_DIGEST_LENGTH];
}

+ (NSString *)SHA224AsString:(NSString *)inString {
    NSData *inData = [inString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *digestData = [[self class] SHA224:inData];
    NSString *outString = [LTMHex encode:digestData];
    return outString;
}

+ (NSData *)SHA256:(NSData *)inData {
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    (void) CC_SHA256( [inData bytes], (CC_LONG)[inData length], hash );
    return ( [NSData dataWithBytes: hash length: CC_SHA256_DIGEST_LENGTH] );
}

+ (NSString *)SHA256AsString:(NSString *)inString {
    NSData *inData = [inString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *digestData = [[self class] SHA256:inData];
    NSString *outString = [LTMHex encode:digestData];
    return outString;
}

+ (NSData *)SHA384:(NSData *)inData {
    unsigned char hash[CC_SHA384_DIGEST_LENGTH];
    (void) CC_SHA384( [inData bytes], (CC_LONG)[inData length], hash );
    return ( [NSData dataWithBytes: hash length: CC_SHA384_DIGEST_LENGTH] );
}

+ (NSString *)SHA384AsString:(NSString *)inString {
    NSData *inData = [inString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *digestData = [[self class] SHA384:inData];
    NSString *outString = [LTMHex encode:digestData];
    return outString;
}

+ (NSData *) SHA512:(NSData *)inData {
    unsigned char hash[CC_SHA512_DIGEST_LENGTH];
    (void) CC_SHA512( [inData bytes], (CC_LONG)[inData length], hash );
    return ( [NSData dataWithBytes: hash length: CC_SHA512_DIGEST_LENGTH] );
}

+ (NSString *)SHA512AsString:(NSString *)inString {
    NSData *inData = [inString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *digestData = [[self class] SHA512:inData];
    NSString *outString = [LTMHex encode:digestData];
    return outString;
}

@end
