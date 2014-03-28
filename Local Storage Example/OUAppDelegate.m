//
//  OUAppDelegate.m
//  Local Storage Example
//
//  Created by Ömer ÜCEL on 28/03/14.
//  Copyright (c) 2014 Ömer ÜCEL. All rights reserved.
//

#import "OUAppDelegate.h"

@implementation OUAppDelegate

@synthesize webView;

- (void)awakeFromNib
{
    // set this class to delegate class for webview
    [webView setFrameLoadDelegate:self];

    // enable HTML5 webStorage
    WebPreferences* prefs = [self.webView preferences];
    if ([prefs respondsToSelector:@selector(_setLocalStorageDatabasePath:)]) {
        NSString* webStoragePath = @"~/Library/Application Support/Local Storage Example";
        [prefs performSelector:@selector(_setLocalStorageDatabasePath:) withObject:webStoragePath];
        NSLog(@"WebStoragePath modified : '%@'", webStoragePath);
    }
    if ([prefs respondsToSelector:@selector(setLocalStorageEnabled:)]) {
        [prefs performSelector:@selector(setLocalStorageEnabled:) withObject:[NSNumber numberWithBool:YES]];
    }

    // open html
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *htmlPath = [resourcePath stringByAppendingString:@"/html/index.html"];
    [[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
}

// Setting this class as a script object. So, in html page we call public methods of this class.
- (void)webView:(WebView *)webView windowScriptObjectAvailable:(WebScriptObject *)windowScriptObject
{
	[windowScriptObject setValue:self forKey:@"JSHelper"];
}

// Public method for javascript
- (NSString *)getSampleTitle
{
    return @"Sample Title";
}

// Public method for javascript
- (void)log:(NSString *)message
{
    NSLog(@"%@", message);
}

// Important method. This method tell our public methods to the webkit.
+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector {
    if (selector == @selector(getSampleTitle)
        || selector == @selector(log:)){
        return NO;
    }

    NSLog(@"%@ received %@ for '%@'", self, NSStringFromSelector(_cmd), NSStringFromSelector(selector));
    return YES;
}

// Important method. This method tell our public methods to the webkit.
+ (BOOL)isKeyExcludedFromWebScript:(const char *)property {
    NSLog(@"%@ received %@ for '%s'", self, NSStringFromSelector(_cmd), property);
    return YES;
}


@end
