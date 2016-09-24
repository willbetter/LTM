//
//  LFNSDictionaryUtilities.h
//  LFToolboxKit
//
//  Created by zhiwei wang on 16/7/1.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTMNSDictionary : NSObject

/// 返回所有key (按字典序排列)
+ (NSArray *)allKeysSorted:(NSDictionary *)dictionary;

/// 返回所有value (按key的字典序排列)
+ (NSArray *)allValuesSortedByKeys:(NSDictionary *)dictionary;

#pragma mark - Dictionary Value Getter
///=============================================================================
/// @name Dictionary Value Getter
///=============================================================================
+ (double)dictionary:(NSDictionary *)dictionary doubleForKey:(NSString *)key defaultValue:(double)def;

+ (float)dictionary:(NSDictionary *)dictionary floatForKey:(NSString *)key defaultValue:(float)def;

+ (int)dictionary:(NSDictionary *)dictionary intForKey:(NSString *)key defaultValue:(int)def;

+ (NSInteger)dictionary:(NSDictionary *)dictionary integerForKey:(NSString *)key defaultValue:(NSInteger)def;

+ (NSUInteger)dictionary:(NSDictionary *)dictionary unsignedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)def;

+ (long)dictionary:(NSDictionary *)dictionary longForKey:(NSString *)key defaultValue:(long)def;

+ (long long)dictionary:(NSDictionary *)dictionary longLongForKey:(NSString *)key defaultValue:(long long)def;

+ (BOOL)dictionary:(NSDictionary *)dictionary boolForKey:(NSString *)key defaultValue:(BOOL)def;

+ (NSString *)dictionary:(NSDictionary *)dictionary stringForKey:(NSString *)key defaultValue:(NSString *)def;

+ (NSNumber *)dictionary:(NSDictionary *)dictionary numberForKey:(NSString *)key defaultValue:(NSNumber *)def;

+ (void)dictionary:(NSMutableDictionary *)dictionary setObject:(id)object forKey:(id<NSCopying>)key;



@end
