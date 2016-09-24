//
//  LFNSDictionaryUtilities.m
//  LFToolboxKit
//
//  Created by zhiwei wang on 16/7/1.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import "LTMNSDictionary.h"

static NSNumber *NSNumberFromID(id value) {
    static NSCharacterSet *dot;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dot = [NSCharacterSet characterSetWithRange:NSMakeRange('.', 1)];
    });
    if (!value || value == [NSNull null]) return nil;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) {
        NSString *lower = ((NSString *)value).lowercaseString;
        if ([lower isEqualToString:@"true"] || [lower isEqualToString:@"yes"]) return @(YES);
        if ([lower isEqualToString:@"false"] || [lower isEqualToString:@"no"]) return @(NO);
        if ([lower isEqualToString:@"nil"] || [lower isEqualToString:@"null"]) return nil;
        if ([lower isEqualToString:@"<nil>"] || [lower isEqualToString:@"<null>"]) return nil;
        if ([(NSString *)value rangeOfCharacterFromSet:dot].location != NSNotFound) {
            return @(((NSString *)value).doubleValue);
        } else {
            return @(((NSString *)value).longLongValue);
        }
    }
    return nil;
}

#define RETURN_VALUE(_type_)                          \
    if (!dictionary) return def;                      \
    if (!key) return def;                             \
    id value = dictionary[key];                             \
    if (!value || value == [NSNull null]) return def; \
    if ([value isKindOfClass:[NSNumber class]])       \
        return ((NSNumber *)value)._type_;            \
    if ([value isKindOfClass:[NSString class]]) {     \
        NSNumber *num = NSNumberFromID(value);        \
        if (!num) return def;                         \
        return num._type_;                            \
    }                                                 \
    return def;


@implementation LTMNSDictionary

+ (NSArray *)allKeysSorted:(NSDictionary *)dictionary{
    
    return [[dictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

+ (NSArray *)allValuesSortedByKeys:(NSDictionary *)dictionary{
    
    NSArray *sortedKeys = [self allKeysSorted:dictionary];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [sortedKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:[dictionary objectForKey:obj]];
    }];
    return arr;

}

#pragma mark - Dictionary Value Getter
///=============================================================================
/// @name Dictionary Value Getter
///=============================================================================
+ (double)dictionary:(NSDictionary *)dictionary doubleForKey:(NSString *)key defaultValue:(double)def{
    
    RETURN_VALUE(doubleValue);
}

+ (float)dictionary:(NSDictionary *)dictionary floatForKey:(NSString *)key defaultValue:(float)def{
    
    RETURN_VALUE(floatValue);
}

+ (int)dictionary:(NSDictionary *)dictionary intForKey:(NSString *)key defaultValue:(int)def{
    
    RETURN_VALUE(intValue);
}

+ (NSInteger)dictionary:(NSDictionary *)dictionary integerForKey:(NSString *)key defaultValue:(NSInteger)def{
    
    RETURN_VALUE(integerValue);
}

+ (NSUInteger)dictionary:(NSDictionary *)dictionary unsignedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)def{
    
    RETURN_VALUE(unsignedIntegerValue);
}

+ (long)dictionary:(NSDictionary *)dictionary longForKey:(NSString *)key defaultValue:(long)def{
    
    RETURN_VALUE(longValue);
}

+ (long long)dictionary:(NSDictionary *)dictionary longLongForKey:(NSString *)key defaultValue:(long long)def{
    
    RETURN_VALUE(longLongValue);
}

+ (BOOL)dictionary:(NSDictionary *)dictionary boolForKey:(NSString *)key defaultValue:(BOOL)def{
    
    RETURN_VALUE(boolValue);
}

+ (NSString *)dictionary:(NSDictionary *)dictionary stringForKey:(NSString *)key defaultValue:(NSString *)def{
    
    if (!dictionary) return def;
    if (!key) return def;
    id value = dictionary[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSString class]]) return value;
    if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value).stringValue;
    if ([value isKindOfClass:[NSURL class]]) return ((NSURL *)value).absoluteString;
    return def;
}

+ (NSNumber *)dictionary:(NSDictionary *)dictionary numberForKey:(NSString *)key defaultValue:(NSNumber *)def{
    if (!dictionary) return def;
    if (!key) return def;
    id value = dictionary[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) {
        NSNumber *num = NSNumberFromID(value);
        if (!num) num = def;
        return num;
    }
    return def;
}

+ (void)dictionary:(NSMutableDictionary *)dictionary setObject:(id)object forKey:(id<NSCopying>)key{
    
    if (object && key) {
        [dictionary setObject:object forKey:key];
    }
}

@end
