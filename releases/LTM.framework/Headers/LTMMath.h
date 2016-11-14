//
//  LFMath.h
//  LaiFeng
//
//  Created by wangxiaoxiang on 16/6/12.
//  Copyright © 2016年 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


@interface LTMMath : NSObject

#pragma mark -
#pragma mark - floor && ceil
+ (CGRect)floorCGRect:(CGRect)bounds;
+ (CGRect)ceilCGRect:(CGRect)bounds;

+ (CGFloat)floorCGFloat:(CGFloat)floatValue;
+ (CGFloat)ceilCGFloat:(CGFloat)floatValue;

+ (CGSize)floorCGSize:(CGSize)size;
+ (CGSize)ceilCGSize:(CGSize)size;

+ (CGPoint)floorCGPoint:(CGPoint)point;
+ (CGPoint)ceilCGPoint:(CGPoint)point;

#pragma mark -
#pragma mark - hash
+ (NSUInteger)hashWithCGFloat:(CGFloat)value;
+ (NSUInteger)hashWithCString:(const char *)value;
+ (NSUInteger)hashWithDouble:(double)value;
+ (NSUInteger)hashWithFloat:(float)value;
+ (NSUInteger)hashWithInteger:(NSUInteger)value;
+ (NSUInteger)hashWithInteger:(NSUInteger)value1 integer:(NSUInteger)value2;
+ (NSUInteger)hashWithIntegerArray:(NSUInteger *)values count:(NSUInteger)count;
+ (NSUInteger)hashWithLong:(unsigned long long)value;
+ (NSUInteger)hashWithPointer:(const void *)value;

@end
