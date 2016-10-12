//
//  UTKURLCoder.m
//  UTK
//
//  Created by wangxiaoxiang on 16/5/19.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import "LTMURLCoder.h"


@implementation LTMURLCoder

+ (NSString *)decode:(NSString *)value
{
    value = [value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
    return value;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+ (NSString *)encode:(NSString *)value
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)value,
                                                                                 NULL, // characters to leave unescaped
                                                                                 CFSTR(":!*();@/&?+$,='"),
                                                                                 kCFStringEncodingUTF8);
}
#pragma clang diagnostic pop
@end
