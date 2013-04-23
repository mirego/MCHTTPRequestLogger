//
// MCHTTPRequestLogger.m
//
// Copyright (c) 2013, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
// POSSIBILITY OF SUCH DAMAGE.

#import "MCHTTPRequestLogger.h"
#import "AFHTTPRequestOperation.h"

static NSString* stringForStatusCode(NSUInteger statusCode) {
    NSDictionary *statusCodeDictionary  = @{
    @100 : @"Continue",
    @101 : @"Switching Protocols",
    @102 : @"Processing",

    @200 : @"OK",
    @201 : @"Created",
    @202 : @"Accepted",
    @203 : @"Non-Authoritative Information",
    @204 : @"No Content",
    @205 : @"Reset Content",
    @206 : @"Partial Content",
    @207 : @"Multi-Status",
    @226 : @"IM Used",

    @300 : @"Multiple Choices",
    @301 : @"Moved Permanently",
    @302 : @"Found",
    @303 : @"See Other",
    @304 : @"Not Modified",
    @305 : @"Use Proxy",
    @307 : @"Temporary Redirect",

    @400 : @"Bad Request",
    @401 : @"Unauthorized",
    @402 : @"Payment Required",
    @403 : @"Forbidden",
    @404 : @"Not Found",
    @405 : @"Method Not Allowed",
    @406 : @"Not Acceptable",
    @407 : @"Proxy Authentication Required",
    @408 : @"Request Timeout",
    @409 : @"Conflict",
    @410 : @"Gone",
    @411 : @"Length Required",
    @412 : @"Precondition Failed",
    @413 : @"Request Entity Too Large",
    @414 : @"Request-URI Too Long",
    @415 : @"Unsupported Media Type",
    @416 : @"Requested Range Not Satisfiable",
    @417 : @"Expectation Failed́",
    @418 : @"I'm a teapot",
    @422 : @"Unprocessable Entity",
    @423 : @"Locked",
    @424 : @"Failed Dependency",
    @426 : @"Upgrade Required",

    @500 : @"Internal Server Error",
    @501 : @"Not Implemented",
    @502 : @"Bad Gateway",
    @503 : @"Service Unavailable",
    @504 : @"Gateway Timeout",
    @505 : @"HTTP Version Not Supported",
    @507 : @"Insufficient Storage",
    @510 : @"Not Extended",
    };

    return statusCodeDictionary[@(statusCode)];
}

@implementation MCHTTPRequestLogger

+ (MCHTTPRequestLogger*)sharedLogger
{
    static MCHTTPRequestLogger* sharedLogger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLogger = [[MCHTTPRequestLogger alloc] init];
    });

    return sharedLogger;
}

- (void)dealloc
{
    [self stopLogging];
}

- (void)startLogging
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(operationDidStart:) name:AFNetworkingOperationDidStartNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(operationDidFinish:) name:AFNetworkingOperationDidFinishNotification object:nil];
}

- (void)stopLogging
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//------------------------------------------------------------------------------
#pragma mark - Notification Handlers
//------------------------------------------------------------------------------

- (void)operationDidStart:(NSNotification*)notification
{
    id notificationObject = [notification object];
    if (![notificationObject isKindOfClass:[AFHTTPRequestOperation class]]) return;

    AFHTTPRequestOperation* operation = (AFHTTPRequestOperation*)notificationObject;

    NSString* body = nil;
    if ([operation.request HTTPBody]) {
        body = [[NSString alloc] initWithData:[operation.request HTTPBody] encoding:NSUTF8StringEncoding];
    }

    NSURLRequest* request = operation.request;

    NSMutableString* output = [NSMutableString string];
    [output appendString:@"\n--------------------------------------------------------------------------------\n"];
    [output appendFormat:@"%@ %@%@ HTTP/1.1\n", [request HTTPMethod], [[request URL] path], ([[request URL] query] ? [NSString stringWithFormat:@"?%@", [[request URL] query]] : @"")];
    [output appendFormat:@"Host: %@\n", [[request URL] host]];
    for (NSString* name in [request allHTTPHeaderFields]) {
        [output appendFormat:@"%@: %@\n", name, [request allHTTPHeaderFields][name]];
    }
    [output appendString:@"\n\n"];
    if (nil != body) {
        [output appendString:body];
    }
    [output appendString:@"\n--------------------------------------------------------------------------------\n"];

    NSLog(@"%@", output);
}

- (void)operationDidFinish:(NSNotification*)notification
{
    id notificationObject = [notification object];
    if (![notificationObject isKindOfClass:[AFHTTPRequestOperation class]]) return;

    AFHTTPRequestOperation* operation = (AFHTTPRequestOperation*)notificationObject;

    NSURLRequest* request = operation.request;
    NSHTTPURLResponse* response = operation.response;

    NSMutableString* output = [NSMutableString string];
    [output appendString:@"\n--------------------------------------------------------------------------------\n"];
    [output appendFormat:@"HTTP/1.1 %ld %@ (%@ %@%@)\n", (long)[response statusCode], stringForStatusCode([response statusCode]), [request HTTPMethod], [[request URL] path], ([[request URL] query] ? [NSString stringWithFormat:@"?%@", [[request URL] query]] : @"")];
    for (NSString* name in [response allHeaderFields]) {
        [output appendFormat:@"%@: %@\n", name, [response allHeaderFields][name]];
    }
    [output appendString:@"\n\n"];
    if (nil != operation.responseString) {
        [output appendString:operation.responseString];
    }
    [output appendString:@"\n--------------------------------------------------------------------------------\n"];

    NSLog(@"%@", output);
}

@end
