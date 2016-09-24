//
//  GTMStringEncoding.h
//
//  Copyright 2010 Google Inc.
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

@interface LTMStringEncoding : NSObject {
@private
    NSData *_charMapData;
    char *_charMap;
    int _reverseCharMap[128];
    int _shift;
    int _mask;
    int _padLength;
}

@property (nonatomic, assign) BOOL doPad;

@property (nonatomic, assign) char paddingChar;

- (instancetype)initWithString:(NSString *)string;
+ (instancetype)stringEncodingWithString:(NSString *)string;

//standard encoding.
+ (instancetype)binaryStringEncoding;
+ (instancetype)hexStringEncoding;
+ (instancetype)base64StringEncoding;
+ (instancetype)base64WebsafeStringEncoding;

- (void)addDecodeSynonyms:(NSString *)synonyms;

- (void)ignoreCharacters:(NSString *)chars;

- (NSString *)encode:(NSData *)data;
- (NSString *)encodeString:(NSString *)string;

- (NSData *)decode:(NSString *)string;
- (NSString *)stringByDecoding:(NSString *)string;


@end