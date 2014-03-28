//
//  OUAppDelegate.h
//  Local Storage Example
//
//  Created by Ömer ÜCEL on 28/03/14.
//  Copyright (c) 2014 Ömer ÜCEL. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface OUAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet WebView *webView;

- (void)webView:(WebView *)webView windowScriptObjectAvailable:(WebScriptObject *)windowScriptObject;

- (NSString *)getSampleTitle;
- (void)log:(NSString *)message;

@end
