/*
   Project: uroswm

   Copyright (C) 2015 Alex Sangiuliano

   Author: Alex Sangiuliano

   Created: 2015-04-12 10:21:47 +0200 by Alex Sangiuliano

*/

#import "UrosWindowManager.h"
#import "UrosScreen.h"
#import <XCBKit/XCBException.h>
#import <XCBKit/XCBScreen.h>
#import <XCBKit/XCBWindow.h>
#import <XCBKit/ICCCM.h>
#import <XCBKit/EWMH.h>
#import <XCBKit/XCBAtomCache.h>

#include <xcb/xproto.h>

@implementation UrosWindowManager

- (id) init
{
    self = [super init];
    
    if (self == nil)
    {
        return nil;
    }

    theConnection = [XCBConnection sharedConnection];
    [theConnection setDelegate:self];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver: self
                      selector: @selector(windowDidMap:)
                          name: XCBWindowDidMapNotification
                        object: nil];
    
    [defaultCenter addObserver: self
                      selector: @selector(windowBecomeAvailable:)
                          name: XCBWindowBecomeAvailableNotification
                        object: nil];
    
    [[XCBAtomCache sharedInstance] cacheAtoms: ICCCMAtomsList()];
    [[XCBAtomCache sharedInstance] cacheAtoms: EWMHAtomsList()];
    
    uint32_t screen_id = 0;
    FOREACH([theConnection screens], screen, XCBScreen*)
    {
        NSLog(@"Uroswm: what happens %@?", screen);
        urosScreen = [[UrosScreen alloc] initWithScreen: screen id: screen_id++];
        [urosScreen handleScreen];
        NSLog(@"Uroswm: Called?");
    }

    return self;
}

-(void) RunLoop
{
    if (theConnection == nil)
    {
        return;
    }

    [self checkOthersWM];
    NSLog(@"Uroswm: Connected");
    [theConnection startMessageLoop];
}

-(void) checkOthersWM
{
    xcb_generic_error_t *error;
    XCBWindow *rootWindow = [[[theConnection screens] objectAtIndex:0] rootWindow];
    
    //NSLog(@"The rootWindow %@", rootWindow);
    uint32_t mask = XCB_CW_EVENT_MASK;
    uint32_t values[2];
    values[0] = XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT;
    xcb_void_cookie_t cookie = xcb_change_window_attributes_checked([theConnection connection], [rootWindow xcbWindowId], mask, values);
    error = xcb_request_check([theConnection connection], cookie);
    
    if (error != NULL && error->error_code == XCB_ACCESS)
    {
        NSLog(@"Uroswm: Another window manager is running!");
        free(error);
        exit(EXIT_FAILURE);
    }
//check if the code below is correct, for now it works
    //values[0] = 1;CHECK ON THE MANUAL: it should be done in this way, but I don't get the expected beahvior
    values[0] = XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY | XCB_EVENT_MASK_KEY_PRESS;
    xcb_change_window_attributes_checked([theConnection connection], [rootWindow xcbWindowId], mask, values);
}

- (void)finishedProcessingEvents: (XCBConnection*)connection
{
    [connection setNeedsFlush:YES];
}

- (void) windowDidMap:(NSNotification*)notification
{
    NSLog(@"Uroswm: Mapped");
    NSLog(@"Uroswm: Other children %@" ,[[urosScreen screen] childWindows]);
}

-(void) windowBecomeAvailable:(NSNotification*)notification
{
    NSLog(@"Uroswm: Window Availables %@", [notification object]);
    NSLog(@"Uroswm: The parent %@", [[notification object] parent]);
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}
@end
