//
//  LFURLQueryItem.m
//  LTM
//
//  Created by wangxiaoxiang on 16/8/18.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import "LTMURLQueryItem.h"

@implementation LTMURLQueryItem

- (instancetype)init {
    NSAssert(0, @"Usage initWithName:value:");
    return nil;
}

- (instancetype)initWithName:(NSString *)name value:(NSString *)value {
    if (self = [super init]) {
        _name = [name copy];
        _value = [value copy];
    }
    return self;
}

+ (instancetype)queryItemWithName:(NSString *)name value:(NSString *)value {
    return [[self alloc] initWithName:name value:value];
}

- (NSString *)name {
    return [_name copy];
}

- (NSString *)value {
    return [_value copy];
}

#pragma mark -
#pragma mark - coding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_value forKey:@"value"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSString *name = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"name"];
    NSString *value = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"value"];
    return [self initWithName:name value:value];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}



#pragma mark -
#pragma mark - copying
- (id)copyWithZone:(NSZone *)zone {
    return [LTMURLQueryItem queryItemWithName:_name value:_value];
}



@end
