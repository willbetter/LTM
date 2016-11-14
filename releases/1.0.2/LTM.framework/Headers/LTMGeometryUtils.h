//
//  LTMGeometryUtils.h
//
//  Utilities for geometrical utilities such as conversions
//  between different types.
//
//  Copyright 2006-2008 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not
//  use this file except in compliance with the License.  You may obtain a copy
//  of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
//  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
//  License for the specific language governing permissions and limitations under
//  the License.
//

#import <Foundation/Foundation.h>
#import "LTMDefines.h"
#if LTM_IOS_SDK
#import <CoreGraphics/CoreGraphics.h>
#endif //  LTM_IPHONE_SDK

#ifdef __cplusplus
extern "C" {
#endif

enum {
  LTMScaleProportionally = 0,   // Fit proportionally
  LTMScaleToFit,                // Forced fit (distort if necessary)
  LTMScaleNone,                 // Don't scale (clip)
  LTMScaleToFillProportionally = 101  // Scale proportionally to fill area
};
typedef NSUInteger LTMScaling;

enum {
  LTMRectAlignCenter = 0,
  LTMRectAlignTop,
  LTMRectAlignTopLeft,
  LTMRectAlignTopRight,
  LTMRectAlignLeft,
  LTMRectAlignBottom,
  LTMRectAlignBottomLeft,
  LTMRectAlignBottomRight,
  LTMRectAlignRight
};
typedef NSUInteger LTMRectAlignment;

#pragma mark -
#pragma mark CG - Point On Rect
/// Return middle of min X side of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    point located in the middle of min X side of rect
LTM_INLINE CGPoint LTMCGMidMinX(CGRect rect) {
  return CGPointMake(CGRectGetMinX(rect), CGRectGetMidY(rect));
}

/// Return middle of max X side of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    point located in the middle of max X side of rect
LTM_INLINE CGPoint LTMCGMidMaxX(CGRect rect) {
  return CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect));
}

/// Return middle of max Y side of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    point located in the middle of max Y side of rect
LTM_INLINE CGPoint LTMCGMidMaxY(CGRect rect) {
  return CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
}

/// Return middle of min Y side of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    point located in the middle of min Y side of rect
LTM_INLINE CGPoint LTMCGMidMinY(CGRect rect) {
  return CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
}

/// Return center of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    point located in the center of rect
LTM_INLINE CGPoint LTMCGCenter(CGRect rect) {
  return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

#pragma mark -
#pragma mark CG - Rect-Size Conversion

/// Return size of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    size of rectangle
LTM_INLINE CGSize LTMCGRectSize(CGRect rect) {
  return CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
}

/// Return rectangle of size
//
//  Args:
//    size - size
//
//  Returns:
//    rectangle of size (origin 0,0)
LTM_INLINE CGRect LTMCGRectOfSize(CGSize size) {
  return CGRectMake(0.0f, 0.0f, size.width, size.height);
}

#pragma mark -
#pragma mark CG - Rect Scaling and Alignment

///  Scales an CGRect
//
//  Args:
//    inRect: Rect to scale
//    xScale: fraction to scale (1.0 is 100%)
//    yScale: fraction to scale (1.0 is 100%)
//
//  Returns:
//    Converted Rect
LTM_INLINE CGRect LTMCGRectScale(CGRect inRect, CGFloat xScale, CGFloat yScale) {
  return CGRectMake(inRect.origin.x, inRect.origin.y,
                    inRect.size.width * xScale, inRect.size.height * yScale);
}


/// Align rectangles
//
//  Args:
//    alignee - rect to be aligned
//    aligner - rect to be aligned from
//    alignment - way to align the rectangles
CGRect LTMCGAlignRectangles(CGRect alignee, CGRect aligner,
                            LTMRectAlignment alignment);
/// Scale rectangle
//
//  Args:
//    scalee - rect to be scaled
//    size - size to scale to
//    scaling - way to scale the rectangle
CGRect LTMCGScaleRectangleToSize(CGRect scalee, CGSize size,
                                 LTMScaling scaling);

#pragma mark -
#pragma mark CG - Miscellaneous

/// Calculate the distance between two points.
//
//  Args:
//    pt1 first point
//    pt2 second point
//
//  Returns:
//    Distance
LTM_INLINE CGFloat LTMCGDistanceBetweenPoints(CGPoint pt1, CGPoint pt2) {
  CGFloat dX = pt1.x - pt2.x;
  CGFloat dY = pt1.y - pt2.y;
#if CGFLOAT_IS_DOUBLE
  return sqrt(dX * dX + dY * dY);
#else
  return sqrtf(dX * dX + dY * dY);
#endif
}

#if !LTM_IOS_SDK
// iPhone does not have NSTypes defined, only CGTypes. So no NSRect, NSPoint etc.

#pragma mark -
#pragma mark NS <-> CG Rect Conversion

///  Convert from a NSRect to a CGRect.
//
  ///  NSRect are relative to 0,0 in lower left;
///  CGRect are relative to 0,0 in lower left
//
//  Args:
//    inRect: NSRect to convert
//
//  Returns:
//    Converted CGRect
LTM_INLINE CGRect LTMNSRectToCGRect(NSRect inRect) {
  CGRect cg = {
    .origin = {.x = inRect.origin.x, .y = inRect.origin.y},
    .size = {.width = inRect.size.width, .height = inRect.size.height}
  };
  return cg;
}


#pragma mark -
#pragma mark NS <-> CG Size Conversion

///  Convert from a NSSize to a CGSize.
//
//  Args:
//    inSize: NSSize to convert
//
//  Returns:
//    Converted CGSize
LTM_INLINE CGSize LTMNSSizeToCGSize(NSSize inSize) {
  CGSize cg = {.width = inSize.width, .height = inSize.height};
  return cg;
}

#pragma mark -
#pragma mark NS - Point On Rect

/// Return middle of min X side of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    point located in the middle of min X side of rect
LTM_INLINE NSPoint LTMNSMidMinX(NSRect rect) {
  return NSMakePoint(NSMinX(rect), NSMidY(rect));
}

/// Return middle of max X side of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    point located in the middle of max X side of rect
LTM_INLINE NSPoint LTMNSMidMaxX(NSRect rect) {
  return NSMakePoint(NSMaxX(rect), NSMidY(rect));
}

/// Return middle of max Y side of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    point located in the middle of max Y side of rect
LTM_INLINE NSPoint LTMNSMidMaxY(NSRect rect) {
  return NSMakePoint(NSMidX(rect), NSMaxY(rect));
}

/// Return middle of min Y side of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    point located in the middle of min Y side of rect
LTM_INLINE NSPoint LTMNSMidMinY(NSRect rect) {
  return NSMakePoint(NSMidX(rect), NSMinY(rect));
}

/// Return center of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    point located in the center of rect
LTM_INLINE NSPoint LTMNSCenter(NSRect rect) {
  return NSMakePoint(NSMidX(rect), NSMidY(rect));
}

#pragma mark -
#pragma mark NS - Rect-Size Conversion

/// Return size of rectangle
//
//  Args:
//    rect - rectangle
//
//  Returns:
//    size of rectangle
LTM_INLINE NSSize LTMNSRectSize(NSRect rect) {
  return NSMakeSize(NSWidth(rect), NSHeight(rect));
}

/// Return rectangle of size
//
//  Args:
//    size - size
//
//  Returns:
//    rectangle of size (origin 0,0)
LTM_INLINE NSRect LTMNSRectOfSize(NSSize size) {
  return NSMakeRect(0.0f, 0.0f, size.width, size.height);
}

#pragma mark -
#pragma mark NS - Rect Scaling and Alignment

///  Scales an NSRect
//
//  Args:
//    inRect: Rect to scale
//    xScale: fraction to scale (1.0 is 100%)
//    yScale: fraction to scale (1.0 is 100%)
//
//  Returns:
//    Converted Rect
LTM_INLINE NSRect LTMNSRectScale(NSRect inRect, CGFloat xScale, CGFloat yScale) {
  return NSMakeRect(inRect.origin.x, inRect.origin.y,
                    inRect.size.width * xScale, inRect.size.height * yScale);
}

/// Align rectangles
//
//  Args:
//    alignee - rect to be aligned
//    aligner - rect to be aligned from
LTM_INLINE NSRect LTMNSAlignRectangles(NSRect alignee, NSRect aligner,
                                       LTMRectAlignment alignment) {
  return NSRectFromCGRect(LTMCGAlignRectangles(LTMNSRectToCGRect(alignee),
                                               LTMNSRectToCGRect(aligner),
                                               alignment));
}

/// Align a rectangle to another
//
//  Args:
//    scalee - rect to be scaled
//    scaler - rect to scale to
//    scaling - way to scale the rectangle
//    alignment - way to align the scaled rectangle
LTM_INLINE NSRect LTMNSScaleRectToRect(NSRect scalee,
                                       NSRect scaler,
                                       LTMScaling scaling,
                                       LTMRectAlignment alignment) {

  return NSRectFromCGRect(
           LTMCGAlignRectangles(
             LTMCGScaleRectangleToSize(LTMNSRectToCGRect(scalee),
                                       LTMNSSizeToCGSize(scaler.size),
                                       scaling),
             LTMNSRectToCGRect(scaler),
             alignment));
}

/// Scale rectangle
//
//  Args:
//    scalee - rect to be scaled
//    size - size to scale to
//    scaling - way to scale the rectangle
LTM_INLINE NSRect LTMNSScaleRectangleToSize(NSRect scalee, NSSize size,
                                            LTMScaling scaling) {
  return NSRectFromCGRect(LTMCGScaleRectangleToSize(LTMNSRectToCGRect(scalee),
                                                     LTMNSSizeToCGSize(size),
                                                     scaling));
}

#pragma mark -
#pragma mark NS - Miscellaneous

/// Calculate the distance between two points.
//
//  Args:
//    pt1 first point
//    pt2 second point
//
//  Returns:
//    Distance
LTM_INLINE CGFloat LTMNSDistanceBetweenPoints(NSPoint pt1, NSPoint pt2) {
  CGPoint cgpt1 = {.x = pt1.x, .y = pt1.y};
  CGPoint cgpt2 = {.x = pt2.x, .y = pt2.y};
  return LTMCGDistanceBetweenPoints(cgpt1, cgpt2);
}

#endif //  !LTM_IPHONE_SDK

#ifdef __cplusplus
}
#endif
