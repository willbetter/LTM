//
//  LFURLComponents.h
//  LTM
//
//  Created by wangxiaoxiang on 16/8/18.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class LTMURLQueryItem;
@interface LTMURLComponents : NSObject<NSSecureCoding,NSCopying>

- (nullable instancetype)initWithURL:(NSURL *)url;

- (nullable instancetype)initWithString:(NSString *)URLString;

@property (nullable, readonly, copy) NSURL *URL;

@property (nullable, readonly, copy) NSString *string;

@property (nullable, nonatomic, copy) NSString *scheme;
@property (nullable, nonatomic, copy) NSString *user;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSString *host;
@property (nullable, nonatomic, copy) NSNumber *port;
@property (nullable, nonatomic, copy) NSString *path;
@property (nullable, nonatomic, copy) NSString *query;
@property (nullable, nonatomic, copy) NSString *fragment;

@property (nullable, nonatomic, copy) NSArray<LTMURLQueryItem *> *queryItems;


@end

NS_ASSUME_NONNULL_END
