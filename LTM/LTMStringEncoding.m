//
//  GTMStringEncoding.m
//
//  Copyright 2009 Google Inc.
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


#import "LTMStringEncoding.h"
#import "LTMDefines.h"

enum {
    kUnknownChar = -1,
    kPaddingChar = -2,
    kIgnoreChar = -3
};

FOUNDATION_STATIC_INLINE int lcm(int a, int b) {
    for (int aa = a, bb = b;;) {
        if (aa == bb)
            return aa;
        else if (aa < bb)
            aa += a;
        else
            bb += b;
    }
}

@implementation LTMStringEncoding

- (instancetype)init {
    return [self initWithString:nil];
}

- (instancetype)initWithString:(NSString *)string {
    if (self = [super init]) {
        _charMapData = [string dataUsingEncoding:NSASCIIStringEncoding];
        if (!_charMapData) {
            _LTMDevLog(@"Unable to convert string to ASCII");
            return nil;
        }
        _charMap = (char *)_charMapData.bytes;
        NSUInteger length = _charMapData.length;
        if (length < 2 || length > 128 || length & (length - 1)) {
            _LTMDevLog(@"Length not a power of 2 between 2 and 128");
            return nil;
        }
        
        memset(_reverseCharMap, kUnknownChar, sizeof(_reverseCharMap));
        
        for (unsigned int i = 0; i < length; i++) {
            if (_reverseCharMap[(int)_charMap[i]] != kUnknownChar) {
                _LTMDevLog(@"Duplicate character at pos %d",i);
                return nil;
            }
            _reverseCharMap[(int)_charMap[i]] = i;
        }
        
        for (NSUInteger i = 1; i < length; i <<= 1) {
            _shift++;
        }
        _mask = (1 << _shift) - 1;
        _padLength = lcm(8,_shift) / _shift;
    }
    return self;
}

+ (instancetype)stringEncodingWithString:(NSString *)string {
    return [[self alloc] initWithString:string];
}

+ (instancetype)binaryStringEncoding {
    return [self stringEncodingWithString:@"01"];
}

+ (instancetype)hexStringEncoding {
    LTMStringEncoding *ret = [LTMStringEncoding stringEncodingWithString:@"0123456789ABCDEF"];
    [ret addDecodeSynonyms:@"AaBbCcDdEeFf"];
    return ret;
}
+ (instancetype)base64StringEncoding {
    LTMStringEncoding *ret = [self stringEncodingWithString:
                             @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"];
    [ret setPaddingChar:'='];
    [ret setDoPad:YES];
    return ret;
}
+ (instancetype)base64WebsafeStringEncoding {
    LTMStringEncoding *ret = [self stringEncodingWithString:
                             @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"];
    [ret setPaddingChar:'='];
    [ret setDoPad:YES];
    return ret;
}

- (NSString *)description {
    // TODO(iwade) track synonyms
    return [NSString stringWithFormat:@"<Base%d StringEncoder: %@>",
            1 << _shift, _charMapData];
}

- (void)setPaddingChar:(char)paddingChar {
    _paddingChar = paddingChar;
    _reverseCharMap[(int)paddingChar] = kPaddingChar;
}

- (void)addDecodeSynonyms:(NSString *)synonyms {
    char *buf = (char *)[synonyms cStringUsingEncoding:NSASCIIStringEncoding];
    int val = kUnknownChar;
    
    while (*buf) {
        int c = *buf++;
        if (_reverseCharMap[c] == kUnknownChar) {
            _reverseCharMap[c] = val;
        }else {
            val = _reverseCharMap[c];
        }
    }
}

- (void)ignoreCharacters:(NSString *)chars {
    char *buf = (char *)[chars cStringUsingEncoding:NSASCIIStringEncoding];
    while (*buf) {
        int c = *buf++;
        _reverseCharMap[c] = kIgnoreChar;
    }
}

- (NSString *)encode:(NSData *)inData {
    NSUInteger inLength = inData.length;
    if (inLength <= 0) {
        _LTMDevLog(@"Empty input");
        return @"";
    }
    
    unsigned char *inBuf = (unsigned char *)inData.bytes;
    NSUInteger inPos = 0;
    
    NSUInteger outLength = (inLength * 8 + _shift - 1) / _shift;
    if (_doPad) {
        outLength = ((outLength + _padLength - 1) / _padLength) * _padLength;
    }
    
    NSMutableData *outData = [NSMutableData dataWithLength:outLength];
    unsigned char *outBuf = (unsigned char *)outData.mutableBytes;
    NSUInteger outPos = 0;
    
    int buffer = inBuf[inPos++];
    int bitsLeft = 8;
    
    while (bitsLeft > 0 || inPos < inLength) {
        if (bitsLeft < _shift) {
            if (inPos < inLength) {
                buffer <<= 8;
                buffer |= (inBuf[inPos++] & 0xff);
                bitsLeft += 8;
            } else {
                int pad = _shift - bitsLeft;
                buffer <<= pad;
                bitsLeft += pad;
            }
        }
        int idx = (buffer >> (bitsLeft - _shift)) & _mask;
        bitsLeft -= _shift;
        outBuf[outPos++] = _charMap[idx];
    }
    if (_doPad) {
        while (outPos < outLength)
            outBuf[outPos++] = _paddingChar;
    }
    
    [outData setLength:outPos];
    
    return [[NSString alloc] initWithData:outData encoding:NSASCIIStringEncoding];
    
}

- (NSString *)encodeString:(NSString *)inString {
    return [self encode:[inString dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSData *)decode:(NSString *)inString {
    char *inBuf = (char *)[inString cStringUsingEncoding:NSASCIIStringEncoding];
    if (!inBuf) {
        _LTMDevLog(@"unable to convert buffer to ASCII");
        return nil;
    }
    NSUInteger inLen = strlen(inBuf);
    NSUInteger outLen = inLen * _shift / 8;
    NSMutableData *outData = [NSMutableData dataWithLength:outLen];
    unsigned char *outBuf = (unsigned char *)[outData mutableBytes];
    NSUInteger outPos = 0;
    
    int buffer = 0;
    int bitsLeft = 0;
    BOOL expectPad = NO;
    for (NSUInteger i = 0; i < inLen; i++) {
        int val = _reverseCharMap[(int)inBuf[i]];
        switch (val) {
            case kIgnoreChar:
                break;
            case kPaddingChar:
                expectPad = YES;
                break;
            case kUnknownChar:
                _LTMDevLog(@"Unexpected data in input pos %lu", (unsigned long)i);
                return nil;
            default:
                if (expectPad) {
                    _LTMDevLog(@"Expected further padding characters");
                    return nil;
                }
                buffer <<= _shift;
                buffer |= val & _mask;
                bitsLeft += _shift;
                if (bitsLeft >= 8) {
                    outBuf[outPos++] = (unsigned char)(buffer >> (bitsLeft - 8));
                    bitsLeft -= 8;
                }
                break;
        }
    }
    if (bitsLeft && buffer & ((1 << bitsLeft) - 1)) {
        _LTMDevLog(@"Incomplete trailing data");
        return nil;
    }
    
    // Shorten buffer if needed due to padding chars
    [outData setLength:outPos];
    return outData;
}

- (NSString *)stringByDecoding:(NSString *)string {
    NSData *ret = [self decode:string];
    return [[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding];
}


@end