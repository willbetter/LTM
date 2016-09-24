//
//  LTMDigest.h
//  LTM
//
//  Created by wangxiaoxiang on 16/8/22.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  摘要算法库
 */
@interface LTMDigest : NSObject

+ (NSData/*output data*/ *)MD2:(NSData *)inData;
+ (NSString *)MD2AsString:(NSString *)inString;

+ (NSData/*output data*/ *)MD4:(NSData *)inData;
+ (NSString *)MD4AsString:(NSString *)inString;

+ (NSData/*output data*/ *)MD5:(NSData *)inData;
+ (NSString *)MD5AsString:(NSString *)inString;

+ (NSData/*output data*/ *)SHA1:(NSData *)inData;
+ (NSString *)SHA1AsString:(NSString *)inString;

+ (NSData/*output data*/ *)SHA224:(NSData *)inData;
+ (NSString *)SHA224AsString:(NSString *)inString;

+ (NSData/*output data*/ *)SHA256:(NSData *)inData;
+ (NSString *)SHA256AsString:(NSString *)inString;

+ (NSData/*output data*/ *)SHA384:(NSData *)inData;
+ (NSString *)SHA384AsString:(NSString *)inString;

+ (NSData/*output data*/ *)SHA512:(NSData *)inData;
+ (NSString *)SHA512AsString:(NSString *)inString;


@end
