//
//  UIFont+LTMLineHeight.m
//  LTM
//
//  Created by 汪潇翔 on 30/09/2016.
//  Copyright © 2016 wangxiaoxiang. All rights reserved.
//

#import "LTMUIFont+LineHeight.h"
#import <Availability.h>

@implementation UIFont (LTMLineHeight)
- (CGFloat)ltm_lineHeight {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    // |sizeWithFont:| is deprecated in iOS 7, replaced by |sizeWithAttributes:|
    return [@"Fake line with gjy" sizeWithFont:self].height;
#else
    return [@"Fake line with gjy" sizeWithAttributes:@{NSFontAttributeName:self}].height;
#endif
}
@end
