//
//  UIView+LTMSubtreeDescription.m
//  LTM
//
//  Created by 汪潇翔 on 30/09/2016.
//  Copyright © 2016 wangxiaoxiang. All rights reserved.
//

#import "LTMUIView+SubtreeDescription.h"
static void _LTMAppendLabelFloat(NSMutableString *s, NSString *label, float f) {
    [s appendString:label];
    // Respects gcc warning about using == with floats.
    if (fabs(f - floor(f)) < 1.0e-8) { // Essentially integer.
        int d = f;
        // Respects gcc warning about casting floats to ints.
        [s appendFormat:@"%d", d];
    } else {
        [s appendFormat:@"%3.1f", f];
    }
}

static NSMutableString *_LTMSublayerDescriptionLine(CALayer *layer) {
    NSMutableString *result = [NSMutableString string];
    [result appendFormat:@"%@ %p {", [layer class], layer];
    CGRect frame = [layer frame];
    if (!CGRectIsEmpty(frame)) {
        _LTMAppendLabelFloat(result, @"x:", frame.origin.x);
        _LTMAppendLabelFloat(result, @" y:", frame.origin.y);
        _LTMAppendLabelFloat(result, @" w:", frame.size.width);
        _LTMAppendLabelFloat(result, @" h:", frame.size.height);
    }
    [result appendFormat:@"}"];
    if ([layer isHidden]) {
        [result appendString:@" hid"];
    }
    [result appendString:@"\n"];
    return result;
}

// |sublayersDescription| has a guard so we'll only call this if it is safe
// to call.
static NSMutableString *_LTMSublayerDescriptionAtLevel(CALayer *layer, int level) {
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < level; ++i) {
        [result appendString:@"  "];
    }
    [result appendString:_LTMSublayerDescriptionLine(layer)];
    // |sublayers| is defined in the QuartzCore framework, which isn't guaranteed
    // to be linked to this program. (So we don't include the header.)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSArray *layers = [layer performSelector:NSSelectorFromString(@"sublayers")];
#pragma clang pop
    for (CALayer *l in layers) {
        [result appendString:_LTMSublayerDescriptionAtLevel(l, level+1)];
    }
    return result;
}

@implementation UIView (LTMSubtreeDescription)
// TODO: Consider flagging things which might help in debugging:
// - alpha < 10%
// - origin not zero
// - non-opaque
// - transform if not identity
// - view not entirely within ancestor views
// - (possibly) tag==0
- (NSString *)ltm_subtreeDescriptionLine {
    NSMutableString *result = [NSMutableString string];
    [result appendFormat:@"%@ %p {", [self class], self];
    CGRect frame = [self frame];
    if (!CGRectIsEmpty(frame)) {
        _LTMAppendLabelFloat(result, @"x:", frame.origin.x);
        _LTMAppendLabelFloat(result, @" y:", frame.origin.y);
        _LTMAppendLabelFloat(result, @" w:", frame.size.width);
        _LTMAppendLabelFloat(result, @" h:", frame.size.height);
    }
    [result appendString:@"}"];
    if ([self isHidden]) {
        [result appendString:@" hid"];
    }
    
    if ([self respondsToSelector:@selector(ltm_viewDescriptionLine)]) {
        NSString *customDescription =
        [self performSelector:@selector(ltm_viewDescriptionLine)];
        if (customDescription != nil) {
            [result appendFormat:@" %@", customDescription];
        }
    }
    
    [result appendString:@"\n"];
    return result;
}

- (NSString *)ltm_subtreeDescriptionAtLevel:(int)level {
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < level; ++i) {
        [result appendString:@"  "];
    }
    [result appendString:[self ltm_subtreeDescriptionLine]];
    for (UIView *v in [self subviews]) {
        [result appendString:[v ltm_subtreeDescriptionAtLevel:level+1]];
    }
    return result;
}

- (NSString *)ltm_subtreeDescription {
    NSMutableString *result =
    [[self ltm_subtreeDescriptionLine] mutableCopy];
    for (UIView *v in [self subviews]) {
        [result appendString:[v ltm_subtreeDescriptionAtLevel:1]];
    }
    return result;
}

// for debugging dump the layer hierarchy, frames and isHidden.
- (NSString *)ltm_sublayersDescription {
    CALayer *layer = [self layer];
    SEL sublayers = NSSelectorFromString(@"sublayers");
    if (![layer respondsToSelector:sublayers]) {
        return @"*** Sorry: This app is not linked with the QuartzCore framework.";
    }
    NSMutableString *result = _LTMSublayerDescriptionLine(layer);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSArray *layers = [layer performSelector:sublayers];
#pragma clang diagnostic pop
    for (CALayer *l in layers) {
        [result appendString:_LTMSublayerDescriptionAtLevel(l, 1)];
    }
    return result;
}
@end
