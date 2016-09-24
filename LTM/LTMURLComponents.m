//
//  LFURLComponents.m
//  LTM
//
//  Created by wangxiaoxiang on 16/8/18.
//  Copyright © 2016年 wangxiaoxiang. All rights reserved.
//

#import "LTMURLComponents.h"
#import "LTMDefines.h"
#import "LTMURLArguments.h"
#define kLTMURLComponentsURLString      @"URLString"

@implementation LTMURLComponents


- (instancetype)initWithString:(NSString *)URLString {
    if (self = [super init]) {
        _LTMDevAssert(URLString,@"URLString must not be nil");
        _string = URLString;
        
        NSURL *url = [NSURL URLWithString:URLString];
        _LTMDevAssert(url,@"URL must not be nil");
        _URL = url;
        
        _scheme   = url.scheme;
        _user     = url.user;
        _password = url.password;
        _host     = url.host;
        _port     = url.port;
        _path     = url.path;
        _query    = url.query;
        _fragment = url.fragment;
        _queryItems = [LTMURLArguments itemsWithQueryString:_query];
        [self _updateURL];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)url {
    return [self initWithString:[url absoluteString]];
}

#pragma mark -
#pragma mark - coding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSString *URLString = [aDecoder decodeObjectOfClass:[NSString class] forKey:kLTMURLComponentsURLString];
    return [self initWithString:URLString];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_string forKey:kLTMURLComponentsURLString];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark -
#pragma mark - copying 

- (id)copyWithZone:(NSZone *)zone {
    LTMURLComponents *components = [[LTMURLComponents alloc] initWithString:_string];
    return components;
}

#pragma mark -
#pragma mark - setter
- (void)setScheme:(NSString *)scheme {
    if ([_scheme isEqualToString:scheme]) {
        return;
    }
    _scheme = scheme;
    [self _updateURL];
}

- (void)setUser:(NSString *)user {
    if ([_user isEqualToString:user]) {
        return;
    }
    _user = user;
    [self _updateURL];
}

- (void)setPassword:(NSString *)password {
    if ([_password isEqualToString:password]) {
        return;
    }
    _password = password;
    [self _updateURL];
}

- (void)setHost:(NSString *)host {
    if ([_host isEqualToString:host]) {
        return;
    }
    _host = host;
    [self _updateURL];
}

- (void)setPort:(NSNumber *)port {
    if ([_port isEqualToNumber:port]) {
        return;
    }
    _port = port;
    [self _updateURL];
}

- (void)setPath:(NSString *)path {
    if ([_path isEqualToString:path]) {
        return;
    }
    _path = path;
    [self _updateURL];
}

- (void)setQuery:(NSString *)query {
    if ([_query isEqualToString:query]) {
        return;
    }
    _query = query;
    _queryItems = [LTMURLArguments itemsWithQueryString:_query];
    [self _updateURL];
}

- (void)setFragment:(NSString *)fragment {
    if ([_fragment isEqualToString:fragment]) {
        return;
    }
    _fragment = fragment;
    [self _updateURL];
}

- (void)setQueryItems:(NSArray<LTMURLQueryItem *> *)queryItems {
    if ([_queryItems isEqualToArray:queryItems]) {
        return;
    }
    _queryItems = queryItems;
    _query  = [LTMURLArguments queryStringWithItems:queryItems error:nil invalidObjectHandler:nil];
    [self _updateURL];
}


#pragma mark -
#pragma mark - private methods
- (void)_updateURL {
    _string = [[self class] URLStringWithScheme:_scheme
                                           user:_user
                                       password:_password
                                           host:_host
                                           port:_port
                                           path:_path
                                          query:_query
                                       fragment:_fragment];
    
    _URL = [NSURL URLWithString:_string];
}


+ (NSString *)URLStringWithScheme:(NSString *)scheme
                             user:(NSString *)user
                         password:(NSString *)password
                             host:(NSString *)host
                             port:(NSNumber *)port
                             path:(NSString *)path
                            query:(NSString *)query
                         fragment:(NSString *)fragment {
    NSString *URLString = @"";
    if (scheme) {
        URLString = [URLString stringByAppendingFormat:@"%@://",scheme];
    }
    
    if (user && password) {
        URLString = [URLString stringByAppendingFormat:@"%@:%@@",user,password];
    }
    
    if (host) {
        URLString = [URLString stringByAppendingFormat:@"%@",host];
    }
    
    if (port) {
        URLString = [URLString stringByAppendingFormat:@":%@",port];
    }
    
    if (path) {
        URLString = [URLString stringByAppendingFormat:@"/%@",path];
    }
    
    if (query) {
        URLString = [URLString stringByAppendingFormat:@"?%@",query];
    }
    
    if (fragment) {
        URLString = [URLString stringByAppendingFormat:@"#%@",fragment];
    }
    
    return URLString;
}

@end
