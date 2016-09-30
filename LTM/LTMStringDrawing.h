//
//  LTMStringDrawing.h
//  LTMToolbox
//
//  Created by user on 16/8/1.
//  Copyright © 2016年 Youku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTMStringDrawing : NSObject


@end


@interface  NSParagraphStyle (LTMStringDrawing)

+ (NSParagraphStyle *)ltm_paragraphStyleWithMode:(NSLineBreakMode)lineBreakMode;

@end

@interface NSString (LTMStringDrawing)

- (CGRect)ltm_boundingRectWithSize:(CGSize)size
                              font:(nullable UIFont *)font;

- (CGRect)ltm_boundingRectWithSize:(CGSize)size
                              font:(nullable UIFont *)font
                             style:(nullable NSParagraphStyle *)paragraphStyle;

- (CGRect)ltm_boundingRectWithSize:(CGSize)size
                              font:(nullable UIFont *)font
                             style:(nullable NSParagraphStyle *)paragraphStyle
                           context:(nullable NSStringDrawingContext *)context;

- (CGRect)ltm_boundingRectWithSize:(CGSize)size
                           options:(NSStringDrawingOptions)options
                              font:(nullable UIFont *)font
                             style:(nullable NSParagraphStyle *)paragraphStyle
                           context:(nullable NSStringDrawingContext *)context;

@end


@interface NSAttributedString (LTMStringDrawing)

- (CGRect)ltm_boundingRectWithSize:(CGSize)size;
- (CGRect)ltm_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options;
- (CGRect)ltm_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options context:(nullable NSStringDrawingContext *)context;
@end


NS_ASSUME_NONNULL_END
