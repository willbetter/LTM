//
//  NSCoder+LTMExtendedCoder.h
//  LTM
//
//  Created by wangxiaoxiang on 16/8/22.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class NSKeyedUnarchiver;
@interface NSCoder (LTMExtendedCoderAddtions)

- (nullable NSString *)ltm_decodeStringValueforKey:(NSString *)key;

- (nullable NSNumber *)ltm_decodeNumberValueforKey:(NSString *)key;

- (nullable NSArray *)ltm_decodeArrayValueforKey:(NSString *)key;

- (nullable NSDictionary *)ltm_decodeDictionaryValueforKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
