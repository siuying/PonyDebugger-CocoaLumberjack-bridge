//
//  DDLog+PonyDebuggerBridge.m
//  PonyDebugger-CocoaLumberjack-bridge
//
//  Created by Francis Chong on 16/4/13.
//  Copyright (c) 2013 Ignition Soft. All rights reserved.
//

#import "DDLog+PonyDebuggerBridge.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>

#import "DDLog.h"
#import "PDDebugger.h"
#import "PDConsoleDomainController.h"

@implementation DDLog (PonyDebuggerBridge)

+(void) load {
    [DDLog jr_swizzleClassMethod:@selector(log:level:flag:context:file:function:line:tag:format:)
                 withClassMethod:@selector(PonyDebuggerBridge_log:level:flag:context:file:function:line:tag:format:)
                           error:NULL];
}

+ (void)PonyDebuggerBridge_log:(BOOL)asynchronous
      level:(int)level
       flag:(int)flag
    context:(int)context
       file:(const char *)file
   function:(const char *)function
       line:(int)line
        tag:(id)tag
     format:(NSString *)format, ... {
	__block va_list args, args2;
    va_start(args, format);
    va_copy(args2, args);

    // send to DDLog as usual
    [self log:asynchronous level:level flag:flag context:context file:file function:function line:line tag:tag format:format args:args];

    // send to PonyDebugger
    __block id obj;
    NSMutableArray* params = [NSMutableArray array];
    NSCharacterSet* escape = [NSCharacterSet characterSetWithCharactersInString:@"%"];
    NSArray* components = [format componentsSeparatedByCharactersInSet:escape];
    [components enumerateObjectsUsingBlock:^(NSString* str, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            [params addObject:str];
        } else if ([str hasPrefix:@"%"]) {
            [params addObject:str];
        } else if ([str length] > 0) {
            [params addObject:[str substringFromIndex:1]];
            obj = va_arg(args2, id);
            [params addObject:obj];
        }
    }];
    [[PDConsoleDomainController defaultInstance] logWithArguments:params
                                                         severity:[self PonyDebuggerBridge_levelToString:level]];
    va_end(args2);
    va_end(args);
}

+ (NSString*)PonyDebuggerBridge_levelToString:(int)levelFlag {
    NSString* level;
    switch (levelFlag) {
        case LOG_FLAG_ERROR:
            level = @"error";
            break;
        case LOG_FLAG_WARN:
            level = @"warn";
            break;
        case LOG_FLAG_INFO:
            level = @"info";
            break;
        case LOG_FLAG_VERBOSE:
            level = @"debug";
            break;
        default:
            level = @"log";
            break;
    }
    return level;
}

@end
