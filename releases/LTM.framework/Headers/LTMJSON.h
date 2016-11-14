//
//  LFNSJSONSerializationUtils.h
//  LFToolboxKit
//
//  Created by zhiwei wang on 16/7/4.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTMJSON : NSObject

+ (NSString *)JSONStringForObject:(id)object
                            error:(NSError *__autoreleasing *)errorRef
             invalidObjectHandler:(id(^)(id object, BOOL *stop))invalidObjectHandler;


+ (id)objectForJSONString:(NSString *)string error:(NSError *__autoreleasing *)errorRef;

@end
