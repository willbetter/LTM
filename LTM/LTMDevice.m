//
//  LTMDevice.m
//  LTM
//
//  Created by 汪潇翔 on 28/10/2016.
//  Copyright © 2016 wangxiaoxiang. All rights reserved.
//

#import "LTMDevice.h"
#import <UIKit/UIKit.h>

static const NSInteger kLTMDeviceSystemVersionFirstNumberiOS7 = 7;
static const NSInteger kLTMDeviceSystemVersionFirstNumberiOS8 = 8;
static const NSInteger kLTMDeviceSystemVersionFirstNumberiOS9 = 9;
static const NSInteger kLTMDeviceSystemVersionFirstNumberiOS10 = 10;

@implementation LTMDevice

+ (NSInteger)_systemVersionFirstNumber {
    static NSInteger firstNumber = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray<NSString *> *list = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
        firstNumber = [list.firstObject integerValue];
    });
    return firstNumber;
}

+ (BOOL)greaterThanOrEqual:(NSInteger)systemVersionFirstNumber {
    return [LTMDevice _systemVersionFirstNumber] >= systemVersionFirstNumber;
}

+ (BOOL)greaterThanOrEqualiOS7 {
    return [self greaterThanOrEqual:kLTMDeviceSystemVersionFirstNumberiOS7];
}

+ (BOOL)greaterThanOrEqualiOS8 {
      return [self greaterThanOrEqual:kLTMDeviceSystemVersionFirstNumberiOS8];
}

+ (BOOL)greaterThanOrEqualiOS9 {
      return [self greaterThanOrEqual:kLTMDeviceSystemVersionFirstNumberiOS9];
}

+ (BOOL)greaterThanOrEqualiOS10 {
      return [self greaterThanOrEqual:kLTMDeviceSystemVersionFirstNumberiOS10];
}

@end
