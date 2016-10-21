//
//  LTMLightweightProxy.h
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

//
// LTMLightweightProxy
//
// An object which does nothing but stand in for another object and forward
// messages (other than basic NSObject messages) to it, suitable for breaking
// retain cycles. It does *not* retain the represented object, so the
// represented object must be set to nil when that object is deallocated.
//
// Messages sent to a LTMLightweightProxy with no represented object set will
// be silently discarded.
//
@interface LTMLightweightProxy : NSProxy {
 @private
  __weak id _representedObject;
}

// Initializes the object to represent |object|.
- (instancetype)initWithRepresentedObject:(id)object;

+ (instancetype)lightweightProxyWithRepresentedObject:(id)object;

// Gets the object that the proxy represents.
- (id)representedObject;

// Changes the proxy to represent |object|
- (void)setRepresentedObject:(id)object;

@end
