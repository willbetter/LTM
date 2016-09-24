//
//  LTMBase64.h
//  LTMToolbox
//
//  Created by wangxiaoxiang on 16/8/1.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LTMBase64Encoding <NSObject>

@required
+ (NSData *)decodeAsData:(NSString *)string;

+ (NSString *)dacodeAsString:(NSString *)string;

+ (NSString *)encodeData:(NSData *)data;

+ (NSString *)encodeString:(NSString *)string;

@end

@interface LTMBase64 : NSObject<LTMBase64Encoding>

@end

@interface LTMWebSafeBase64 : NSObject<LTMBase64Encoding>

@end
