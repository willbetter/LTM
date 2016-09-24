//
//  NSCoder+LTMExtendedCoder.m
//  LTM
//
//  Created by wangxiaoxiang on 16/8/22.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import "LTMNSCoder+ExtendedCoder.h"

@implementation NSCoder (LTMExtendedCoderAddtions)


- (nullable NSString *)ltm_decodeStringValueforKey:(NSString *)key {
    return [self decodeObjectOfClass:[NSString class] forKey:key];
}

- (nullable NSNumber *)ltm_decodeNumberValueforKey:(NSString *)key {
    return [self decodeObjectOfClass:[NSNumber class] forKey:key];
}

- (nullable NSArray *)ltm_decodeArrayValueforKey:(NSString *)key {
    return [self decodeObjectOfClass:[NSArray class] forKey:key];
}

- (nullable NSDictionary *)ltm_decodeDictionaryValueforKey:(NSString *)key {
    return [self decodeObjectOfClass:[NSDictionary class] forKey:key];
}

@end
