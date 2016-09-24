//
//  LFNSJSONSerializationUtils.m
//  LFToolboxKit
//
//  Created by zhiwei wang on 16/7/4.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import "LTMJSON.h"

@implementation LTMJSON

#pragma mark --public Method
+ (NSString *)JSONStringForObject:(id)object
                            error:(NSError *__autoreleasing *)errorRef
             invalidObjectHandler:(id(^)(id object, BOOL *stop))invalidObjectHandler
{
    if (invalidObjectHandler || ![NSJSONSerialization isValidJSONObject:object]) {
        object = [self _convertObjectToJSONObject:object invalidObjectHandler:invalidObjectHandler stop:NULL];
        if (![NSJSONSerialization isValidJSONObject:object]) {
            if (errorRef != NULL) {
                *errorRef = [NSError errorWithDomain:@"Invalid object for JSON serialization."
                                                code:-1
                                            userInfo:@{NSLocalizedFailureReasonErrorKey:@"JSON error",
                                                                                     NSLocalizedDescriptionKey:@"JSON error"}];
            }
            return nil;
        }
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:errorRef];
    if (!data) {
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (id)objectForJSONString:(NSString *)string error:(NSError *__autoreleasing *)errorRef
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        if (errorRef != NULL) {
            *errorRef = nil;
        }
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:errorRef];
}

#pragma mark --private Method
+ (id)_convertObjectToJSONObject:(id)object
            invalidObjectHandler:(id(^)(id object, BOOL *stop))invalidObjectHandler
                            stop:(BOOL *)stopRef
{
    __block BOOL stop = NO;
    if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
        // good to go, keep the object
    } else if ([object isKindOfClass:[NSURL class]]) {
        object = [(NSURL *)object absoluteString];
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [(NSDictionary *)object enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *dictionaryStop) {
            [self dictionary:dictionary
                   setObject:[self _convertObjectToJSONObject:obj invalidObjectHandler:invalidObjectHandler stop:&stop]
                      forKey:[self stringValue:key]];
            if (stop) {
                *dictionaryStop = YES;
            }
        }];
        object = dictionary;
    } else if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (id obj in (NSArray *)object) {
            id convertedObj = [self _convertObjectToJSONObject:obj invalidObjectHandler:invalidObjectHandler stop:&stop];
            [self array:array addObject:convertedObj];
            if (stop) {
                break;
            }
        }
        object = array;
    } else {
        object = invalidObjectHandler(object, stopRef);
    }
    if (stopRef != NULL) {
        *stopRef = stop;
    }
    return object;
}


+ (void)dictionary:(NSMutableDictionary *)dictionary setObject:(id)object forKey:(id<NSCopying>)key
{
    if (object && key) {
        [dictionary setObject:object forKey:key];
    }
}

+ (void)array:(NSMutableArray *)array addObject:(id)object
{
    if (object) {
        [array addObject:object];
    }
}

+ (NSString *)stringValue:(id)object
{
    if ([object isKindOfClass:[NSString class]]) {
        return (NSString *)object;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object stringValue];
    } else if ([object isKindOfClass:[NSURL class]]) {
        return [(NSURL *)object absoluteString];
    } else {
        return nil;
    }
}



@end
