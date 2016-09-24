//
//  LTMGeometryUtils.m
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

#import "LTMGeometryUtils.h"

/// Align rectangles
//
//  Args:
//    alignee - rect to be aligned
//    aligner - rect to be aligned to
//    alignment - alignment to be applied to alignee based on aligner

CGRect LTMCGAlignRectangles(CGRect alignee, CGRect aligner, LTMRectAlignment alignment) {
  switch (alignment) {
    case LTMRectAlignTop:
      alignee.origin.x = aligner.origin.x + (CGRectGetWidth(aligner) * .5f - CGRectGetWidth(alignee) * .5f);
      alignee.origin.y = aligner.origin.y + CGRectGetHeight(aligner) - CGRectGetHeight(alignee);
      break;
      
    case LTMRectAlignTopLeft:
      alignee.origin.x = aligner.origin.x;
      alignee.origin.y = aligner.origin.y + CGRectGetHeight(aligner) - CGRectGetHeight(alignee);
    break;
    
    case LTMRectAlignTopRight:
      alignee.origin.x = aligner.origin.x + CGRectGetWidth(aligner) - CGRectGetWidth(alignee);
      alignee.origin.y = aligner.origin.y + CGRectGetHeight(aligner) - CGRectGetHeight(alignee);
      break;

    case LTMRectAlignLeft:
      alignee.origin.x = aligner.origin.x;
      alignee.origin.y = aligner.origin.y + (CGRectGetHeight(aligner) * .5f - CGRectGetHeight(alignee) * .5f);
      break;
      
    case LTMRectAlignBottomLeft:
      alignee.origin.x = aligner.origin.x;
      alignee.origin.y = aligner.origin.y;
      break;

    case LTMRectAlignBottom:
      alignee.origin.x = aligner.origin.x + (CGRectGetWidth(aligner) * .5f - CGRectGetWidth(alignee) * .5f);
      alignee.origin.y = aligner.origin.y;
      break;

    case LTMRectAlignBottomRight:
      alignee.origin.x = aligner.origin.x + CGRectGetWidth(aligner) - CGRectGetWidth(alignee);
      alignee.origin.y = aligner.origin.y;
      break;
      
    case LTMRectAlignRight:
      alignee.origin.x = aligner.origin.x + CGRectGetWidth(aligner) - CGRectGetWidth(alignee);
      alignee.origin.y = aligner.origin.y + (CGRectGetHeight(aligner) * .5f - CGRectGetHeight(alignee) * .5f);
      break;
      
    default:
    case LTMRectAlignCenter:
      alignee.origin.x = aligner.origin.x + (CGRectGetWidth(aligner) * .5f - CGRectGetWidth(alignee) * .5f);
      alignee.origin.y = aligner.origin.y + (CGRectGetHeight(aligner) * .5f - CGRectGetHeight(alignee) * .5f);
      break;
  }
  return alignee;
}

CGRect LTMCGScaleRectangleToSize(CGRect scalee, CGSize size, LTMScaling scaling) {
  switch (scaling) {
      
    case LTMScaleToFillProportionally:
    case LTMScaleProportionally: {
      CGFloat height = CGRectGetHeight(scalee);
      CGFloat width = CGRectGetWidth(scalee);
      if (isnormal(height) && isnormal(width) && 
          (height > size.height || width > size.width)) {
        CGFloat horiz = size.width / width;
        CGFloat vert = size.height / height;
        BOOL expand = (scaling == LTMScaleToFillProportionally);
        // We use the smaller scale unless expand is true. In that case, larger.
        CGFloat newScale = ((horiz < vert) ^ expand) ? horiz : vert;
        scalee = LTMCGRectScale(scalee, newScale, newScale);
      }
      break;
    }
    
    case LTMScaleToFit:
      scalee.size = size;
      break;
      
    case LTMScaleNone:
    default:
      // Do nothing
      break;
  }
  return scalee;
}
