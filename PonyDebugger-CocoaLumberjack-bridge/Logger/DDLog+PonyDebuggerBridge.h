//
//  DDLog+PonyDebuggerBridge.h
//  PonyDebugger-CocoaLumberjack-bridge
//
//  Created by Francis Chong on 16/4/13.
//  Copyright (c) 2013 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDLog.h"

@interface DDLog (PonyDebuggerBridge)

+ (void)PonyDebuggerBridge_log:(BOOL)asynchronous
                         level:(int)level
                          flag:(int)flag
                       context:(int)context
                          file:(const char *)file
                      function:(const char *)function
                          line:(int)line
                           tag:(id)tag
                        format:(NSString *)format, ...  NS_FORMAT_FUNCTION(9, 10);

@end
