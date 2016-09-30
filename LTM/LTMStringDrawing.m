//
//  LTMStringDrawing.m
//  LTMToolbox
//
//  Created by user on 16/8/1.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import "LTMStringDrawing.h"

@implementation LTMStringDrawing

@end


@implementation NSParagraphStyle (LTMStringDrawing)

+ (NSParagraphStyle *)ltm_paragraphStyleWithMode:(NSLineBreakMode)lineBreakMode {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = lineBreakMode;
    return paragraphStyle;
}

@end

@implementation NSString (LTMStringDrawing)

- (CGRect)ltm_boundingRectWithSize:(CGSize)size font:(UIFont *)font {
    return [self ltm_boundingRectWithSize:size font:font style:nil context:nil];
}

- (CGRect)ltm_boundingRectWithSize:(CGSize)size font:(UIFont *)font style:(NSParagraphStyle *)paragraphStyle {
    return [self ltm_boundingRectWithSize:size font:font style:paragraphStyle context:nil];
}

- (CGRect)ltm_boundingRectWithSize:(CGSize)size font:(UIFont *)font style:(NSParagraphStyle *)paragraphStyle context:(NSStringDrawingContext *)context {
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    return [self ltm_boundingRectWithSize:size options:options font:font style:paragraphStyle context:context];
}

- (CGRect)ltm_boundingRectWithSize:(CGSize)size
                           options:(NSStringDrawingOptions)options
                              font:(UIFont *)font
                             style:(NSParagraphStyle *)paragraphStyle
                           context:(NSStringDrawingContext *)context {
#if DEBUG
    NSAssert(CGSizeEqualToSize(size, CGSizeZero) == NO, @"size must not be CGSizeZero,by 🚀");
    NSAssert(font != nil, @"font must not be nil, if font equal nil default Helvetica(Neue) 12,by 🚀");
#endif
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    if (font) {
        attributes[NSFontAttributeName] = font;
    }
    
    if (paragraphStyle && ![paragraphStyle isEqual:[NSParagraphStyle defaultParagraphStyle]]) {
        attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    CGRect boundingRect = [self boundingRectWithSize:size
                                             options:options
                                          attributes:attributes
                                             context:context];
    return boundingRect;
}

@end


@implementation NSAttributedString (LTMStringDrawing)

- (CGRect)ltm_boundingRectWithSize:(CGSize)size {
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    return [self ltm_boundingRectWithSize:size options:options context:nil];
}

- (CGRect)ltm_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options {
    return [self ltm_boundingRectWithSize:size options:options context:nil];
}

- (CGRect)ltm_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options context:(nullable NSStringDrawingContext *)context {
    CGRect boundingRect = [self boundingRectWithSize:size options:options context:context];
    return boundingRect;
}

@end
