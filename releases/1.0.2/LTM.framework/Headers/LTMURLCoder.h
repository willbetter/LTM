//
//  UTKURLCoder.h
//  UTK
//
//  Created by wangxiaoxiang on 16/5/19.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTMURLCoder : NSObject

+ (NSString *)encode:(NSString *)string;

+ (NSString *)decode:(NSString *)string;

@end
