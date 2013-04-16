//
//  ViewController.m
//  PonyDebugger-CocoaLumberjack-bridge
//
//  Created by Francis Chong on 15/4/13.
//  Copyright (c) 2013 Ignition Soft. All rights reserved.
//

#import "ViewController.h"
#import "DDLog.h"
#import "PDDebugger.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DDLogInfo(@"loaded! 100%%");
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) test {
    DDLogInfo(@"Hello world: %@ %@", [NSDate date], [UIApplication sharedApplication]);
}

@end
