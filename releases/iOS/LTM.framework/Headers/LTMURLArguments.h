//
//  UTKURLArguments.h
//  UTK
//
//  Created by wangxiaoxiang on 16/5/16.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import "LTMURLCoder.h"

@class LTMURLQueryItem;
@interface LTMURLArguments : NSObject

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)queryString;

+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary
                                  error:(NSError *__autoreleasing *)errorRef;

+ (NSString *)queryStringWithDictionary:(NSDictionary *)dictionary
                                  error:(NSError *__autoreleasing *)errorRef
                   invalidObjectHandler:(id(^)(id object, BOOL *stop))invalidObjectHandler;

@end

@interface LTMURLArguments (LFURLQueryItem);

+ (NSArray<LTMURLQueryItem *> *)itemsWithQueryString:(NSString *)queryString;

+ (NSString *)queryStringWithItems:(NSArray<LTMURLQueryItem *> *)items
                             error:(NSError *__autoreleasing *)errorRef
              invalidObjectHandler:(id(^)(id object, BOOL *stop))invalidObjectHandler;

@end
