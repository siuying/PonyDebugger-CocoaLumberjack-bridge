//
//  PDCLogger.m
//  PonyDebugger-CocoaLumberjack-bridge
//
//  Created by Francis Chong on 15/4/13.
//  Copyright (c) 2013 Ignition Soft. All rights reserved.
//

#import "DDLog.h"
#import "PDCLogger.h"
#import "PDDebugger.h"

@implementation PDCLogger

+ (PDCLogger *)sharedInstance {
    static PDCLogger *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[PDCLogger alloc] init];
    });
    return _instance;
}

- (void)logMessage:(DDLogMessage *)message
{
    NSString* level;
    switch (message->logFlag) {
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
    
    if (formatter) {
        _PDLogObjectsImpl(level, @[[formatter formatLogMessage:message]]);
    } else {
        _PDLogObjectsImpl(level, @[ message->logMsg ]);
    }
}

- (NSString *)loggerName
{
    return @"hk.ignition.logger.PDCLogger";
}

@end
