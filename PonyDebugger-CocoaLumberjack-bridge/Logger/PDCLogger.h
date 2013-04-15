//
//  PDCLogger.h
//  PonyDebugger-CocoaLumberjack-bridge
//
//  Created by Francis Chong on 15/4/13.
//  Copyright (c) 2013 Ignition Soft. All rights reserved.
//

#import "DDLog.h"

@interface PDCLogger : DDAbstractLogger

// Create a shared logger instance
+ (PDCLogger *)sharedInstance;

@end
