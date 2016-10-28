//
//  LTMDevice.h
//  LTM
//
//  Created by 汪潇翔 on 28/10/2016.
//  Copyright © 2016 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTMDevice : NSObject

+ (BOOL)greaterThanOrEqual:(NSInteger)systemVersionFirstNumber;

+ (BOOL)greaterThanOrEqualiOS7;

+ (BOOL)greaterThanOrEqualiOS8;

+ (BOOL)greaterThanOrEqualiOS9;

+ (BOOL)greaterThanOrEqualiOS10;


@end
