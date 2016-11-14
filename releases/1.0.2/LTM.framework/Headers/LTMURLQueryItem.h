//
//  LFURLQueryItem.h
//  LTM
//
//  Created by wangxiaoxiang on 16/8/18.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTMURLQueryItem : NSObject <NSSecureCoding, NSCopying> {
@private
    NSString *_name;
    NSString *_value;
}

@property (readonly) NSString *name;
@property (nullable, readonly) NSString *value;

- (instancetype)initWithName:(NSString *)name value:(nullable NSString *)value; //NS_DESIGNATED_INITIALIZER
+ (instancetype)queryItemWithName:(NSString *)name value:(nullable NSString *)value;


@end
NS_ASSUME_NONNULL_END
