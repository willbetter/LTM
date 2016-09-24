//
//  UTKURLCoder.m
//  UTK
//
//  Created by wangxiaoxiang on 16/5/19.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import "LTMURLCoder.h"

static BOOL g_allowedCharacters = NO;
static BOOL g_stringByRemovingPercentEncoding = NO;


@implementation LTMURLCoder

+ (void)initialize
{
    g_allowedCharacters = [NSString instancesRespondToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)];
    g_stringByRemovingPercentEncoding = [NSString instancesRespondToSelector:@selector(stringByRemovingPercentEncoding)];
}

+ (NSString *)encode:(NSString *)string {
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    
    static NSString * const  allowedCharacters = @"!*'();:@&=+$,/?%#[]";
    if (g_allowedCharacters) {
        static NSCharacterSet * characterSet = nil;
        if (characterSet == nil) {
            characterSet = [NSCharacterSet characterSetWithCharactersInString:allowedCharacters];
        }
        return  [string stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    } else {
        CFStringRef escaped = NULL;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        escaped = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                          (CFStringRef)string,
                                                          NULL,
                                                          (CFStringRef)allowedCharacters,
                                                          kCFStringEncodingUTF8);
#pragma clang diagnostic pop
        
#if defined(__has_feature) && __has_feature(objc_arc)
        return CFBridgingRelease(escaped);
#else
        return [(NSString *)escaped autorelease];
#endif
    }
}

+ (NSString *)decode:(NSString *)string {
    NSMutableString *resultString = [NSMutableString stringWithString:string];
    [resultString replaceOccurrencesOfString:@"+"
                                  withString:@" "
                                     options:NSLiteralSearch
                                       range:NSMakeRange(0, [resultString length])];
    
    
    if (g_stringByRemovingPercentEncoding) {
        return resultString.stringByRemovingPercentEncoding;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [resultString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
    }
    
}
@end
