//
//  LTMHex.h
//  LTMToolbox
//
//  Created by wangxiaoxiang on 16/8/1.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTMHex : NSObject

+ (NSString *)encode:(NSData *)inData;

+ (NSData *)decode:(NSString *)inString;

@end
