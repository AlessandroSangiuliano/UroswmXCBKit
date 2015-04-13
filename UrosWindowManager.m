/*
   Project: uroswm

   Copyright (C) 2015 Free Software Foundation

   Author: alex,,,

   Created: 2015-04-12 10:21:47 +0200 by alex

*/

#import "UrosWindowManager.h"
#import <XCBKit/XCBException.h>
#import <XCBKit/XCBScreen.h>
#import <XCBKit/XCBWindow.h>

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
  return self;
}

-(void) RunLoop
{
    if (theConnection == nil)
    {
        return;
    }

    [self checkOthersWM];
    [theConnection setDelegate:self];
    NSLog(@"Connessuto");
    [theConnection startMessageLoop];
}

-(void) checkOthersWM
{
    xcb_generic_error_t *error;
    //XCBRaiseGenericErrorException(error, @"<unknown>", @"Unknown asynchronous request (from processing event loop)");
    XCBWindow *rootWindow = [[[theConnection screens] objectAtIndex:0] rootWindow];
    NSLog(@"La finestra root %@", rootWindow);
    uint32_t mask = XCB_CW_EVENT_MASK;
    uint32_t values[2];
    values[0] = XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT;
    xcb_void_cookie_t cookie = xcb_change_window_attributes_checked([theConnection connection], [rootWindow xcbWindowId], mask, values);
    error = xcb_request_check([theConnection connection], cookie);
    
    if (error != NULL && error->error_code == XCB_ACCESS)
    {
        NSLog(@"Another window manager is running!");
        free(error);
        exit(EXIT_FAILURE);
    }
}

- (void)finishedProcessingEvents: (XCBConnection*)connection
{
    NSLog(@"Sono chiamato o no %hhu?", [theConnection needsFlush]);
    [connection setNeedsFlush:YES];
     NSLog(@"Sono chiamato dopo o no %hhu?", [theConnection needsFlush]);
}
@end
