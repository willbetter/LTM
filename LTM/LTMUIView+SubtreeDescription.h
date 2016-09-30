//
//  UIView+LTMSubtreeDescription.h
//  LTM
//
//  Created by 汪潇翔 on 30/09/2016.
//  Copyright © 2016 wangxiaoxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LTMSubtreeDescription)
// Returns one line, without leading indent, but with a trailing newline,
// describing the view.
// If you define a |myViewDescriptionLine| method in your own UIView classes,
// this will append that result to its description.
- (NSString *)ltm_subtreeDescriptionLine;

// For debugging. Returns a nicely indented representation of this view's
// subview hierarchy, each with frame and isHidden.
- (NSString *)ltm_subtreeDescription;

// For debugging. Returns a nicely indented representation of this view's
// layer hierarchy, with frames and isHidden.
// Requires QuartzCore to be useful, but your app will still link without it.
// TODO: should there be an analog of myViewDescriptionLine for layers?
- (NSString *)ltm_sublayersDescription;
@end

@protocol LTMUIViewSubtreeDescription
// A UIView can implement this and it can add it's own custom description
// in gtm_subtreeDescriptionLine.
- (NSString *)ltm_viewDescriptionLine;
@end
