//
//  LTMTypeUtility.h
//  LTM
//
//  Created by wangxiaoxiang on 16/8/22.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXPORT BOOL LTMNSStringIsEmpty(NSString *string);

FOUNDATION_EXPORT BOOL LTMNSArrayIsEmpty(NSArray *array);

FOUNDATION_EXPORT BOOL LTMNDictionaryIsEmpty(NSDictionary *dictionary);

FOUNDATION_EXPORT BOOL LTMNSHashTableIsEmpty(NSHashTable *hashTable);

FOUNDATION_EXPORT BOOL LTMNSDataIsEmpty(NSData *data);

FOUNDATION_EXPORT BOOL LTMNSSetIsEmpty(NSSet *set);

FOUNDATION_EXPORT BOOL LTMNSIndexSetIsEmpty(NSIndexSet *set);

FOUNDATION_EXPORT BOOL LTMNSOrderedSetIsEmpty(NSOrderedSet *set);


@interface LTMTypeUtility : NSObject

+ (NSSet *)textLikeEmptyItems;

//MARK:object
+ (NSString *)stringValue:(id)object;
+ (NSArray *)arrayValue:(id)object;
+ (NSDictionary *)dictionaryValue:(id)object;
+ (NSURL *)URLValue:(id)object;

+ (id)objectValue:(id)object;
+ (id)objectValue:(id)object ofClass:(Class)expectedClass;

//MARK:char
+ (char)charValue:(id)object;
+ (unsigned char)unsignedCharValue:(id)object;

//MARK:short
+ (short)shortValue:(id)object;
+ (unsigned short)unsignedShortValue:(id)object;

//MARK:int
+ (int)intValue:(id)object;
+ (unsigned int)unsignedIntValue:(id)object;

//MARK:long
+ (long)longValue:(id)object;
+ (unsigned long)unsignedLongValue:(id)object;


//MARK:long long
+ (long long)longLongValue:(id)object;
+ (unsigned long long)unsignedLongLongValue:(id)object;


//MARK:double
+ (float)floatValue:(id)object;
+ (double)doubleValue:(id)object;
+ (NSTimeInterval)timeIntervalValue:(id)object;

//MARK:integer
+ (NSInteger)integerValue:(id)object;
+ (NSUInteger)unsignedIntegerValue:(id)object;

@end
