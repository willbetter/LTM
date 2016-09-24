//
//  UTKURLArguments.m
//  UTK
//
//  Created by wangxiaoxiang on 16/5/16.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import "LTMURLArguments.h"
#import "LTMURLCoder.h"
#import "LTMURLQueryItem.h"

@implementation LTMURLArguments

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)queryString {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    NSArray *parts = [queryString componentsSeparatedByString:@"&"];
    
    for (NSString *part in parts) {
        if ([part length] == 0) {
            continue;
        }
        
        NSRange index = [part rangeOfString:@"="];
        NSString *key;
        NSString *value;
        
        if (index.location == NSNotFound) {
            key = part;
            value = @"";
        } else {
            key = [part substringToIndex:index.location];
            value = [part substringFromIndex:index.location + index.length];
        }
        key = [LTMURLCoder decode:key];
        value = [LTMURLCoder decode:value];
        if (key && value) {
            result[key] = value;
        }
    }
    return result;
}

+ (id)convertRequestValue:(id)value
{
    if ([value isKindOfClass:[NSNumber class]]) {
        value = [(NSNumber *)value stringValue];
    } else if ([value isKindOfClass:[NSURL class]]) {
        value = [(NSURL *)value absoluteString];
    }
    return value;
}

+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary
                                  error:(NSError *__autoreleasing *)errorRef
                   invalidObjectHandler:(id(^)(id object, BOOL *stop))invalidObjectHandler
{
    NSMutableString *queryString = [[NSMutableString alloc] init];
    __block BOOL hasParameters = NO;
    if (dictionary) {
        NSMutableArray *keys = [[dictionary allKeys] mutableCopy];
        // remove non-string keys, as they are not valid
        [keys filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject isKindOfClass:[NSString class]];
        }]];
        // sort the keys so that the query string order is deterministic
        [keys sortUsingSelector:@selector(compare:)];
        BOOL stop = NO;
        for (NSString *key in keys) {
            id value = [self convertRequestValue:dictionary[key]];
            if ([value isKindOfClass:[NSString class]]) {
                value = [LTMURLCoder encode:value];
            }
            if (invalidObjectHandler && ![value isKindOfClass:[NSString class]]) {
                value = invalidObjectHandler(value, &stop);
                if (stop) {
                    break;
                }
            }
            if (value) {
                if (hasParameters) {
                    [queryString appendString:@"&"];
                }
                [queryString appendFormat:@"%@=%@", key, value];
                hasParameters = YES;
            }
        }
    }
    if (errorRef != NULL) {
        *errorRef = nil;
    }
    return ([queryString length] ? [queryString copy] : nil);
}

+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary error:(NSError *__autoreleasing *)errorRef {
    return [self queryStringWithDictionary:dictionary error:errorRef invalidObjectHandler:nil];
}

@end


@implementation LTMURLArguments (LFURLQueryItem)

+ (NSArray<LTMURLArguments *> *)itemsWithQueryString:(NSString *)queryString {
    NSMutableArray *items = [NSMutableArray array];
    NSArray *parts = [queryString componentsSeparatedByString:@"&"];
    
    for (NSString *part in parts) {
        if ([part length] == 0) {
            continue;
        }
        
        NSRange index = [part rangeOfString:@"="];
        NSString *key;
        NSString *value;
        
        if (index.location == NSNotFound) {
            key = part;
            value = @"";
        } else {
            key = [part substringToIndex:index.location];
            value = [part substringFromIndex:index.location + index.length];
        }
        key = [LTMURLCoder decode:key];
        value = [LTMURLCoder decode:value];
        if (key && value) {
            LTMURLQueryItem *item = [LTMURLQueryItem queryItemWithName:key value:value];
            [items addObject:item];
        }
    }
    return items;
}

+ (NSString *)queryStringWithItems:(NSArray<LTMURLQueryItem *> *)items
                             error:(NSError *__autoreleasing *)errorRef
              invalidObjectHandler:(id(^)(id object, BOOL *stop))invalidObjectHandler {
    NSMutableString *queryString = [[NSMutableString alloc] init];
    __block BOOL hasParameters = NO;
    if (items) {
        // sort the keys so that the query string order is deterministic
        items = [items sortedArrayUsingComparator:^NSComparisonResult(LTMURLQueryItem *  _Nonnull obj1, LTMURLQueryItem *  _Nonnull obj2) {
            return [obj1.name compare:obj2.name];
        }];
        
        BOOL stop = NO;
        for (LTMURLQueryItem *item in items) {
            id value = [self convertRequestValue:item.value];
            if ([value isKindOfClass:[NSString class]]) {
                value = [LTMURLCoder encode:value];
            }
            if (invalidObjectHandler && ![value isKindOfClass:[NSString class]]) {
                value = invalidObjectHandler(value, &stop);
                if (stop) {
                    break;
                }
            }
            if (value) {
                if (hasParameters) {
                    [queryString appendString:@"&"];
                }
                [queryString appendFormat:@"%@=%@", item.name, item.value];
                hasParameters = YES;
            }
        }
    }
    if (errorRef != NULL) {
        *errorRef = nil;
    }
    return ([queryString length] ? [queryString copy] : nil);
}

@end
