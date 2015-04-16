/*
   Project: uroswm

   Copyright (C) 2015 Alex Sangiuliano

   Author: Alex Sangiuliano

   Created: 2015-04-15 9:42:47 +0200 by Alex Sangiuliano

*/

#import "UrosScreen.h"
#import <XCBKit/EWMH.h>
#import <XCBKit/ICCCM.h>

@implementation UrosScreen

- (id) initWithScreen:(XCBScreen*)screen id:(uint32_t)Id
{
    self = [super init];
    
    if (self == nil)
    {
        return nil;
    }
    
    uScreen = screen;
    screen_id = Id;
    
    
    return self;
}

- (XCBScreen*) screen
{
    return uScreen;
}

- (uint32_t) screenId
{
    return screen_id;
}

- (XCBWindow*) rootWindow
{
    return [uScreen rootWindow];
}

- (void) handleScreen
{
    XCBWindow *rootWindow = [self rootWindow];
    managerSelection = [XCBSelection selectionWithAtomNamed: [NSString stringWithFormat: @"WM_S%d", screen_id]];
    
    //I think this method creates a child of the rootWindow
    XCBWindow *window = [rootWindow createChildInRect: XCBMakeRect(0, 0, 1, 1) borderWidth: 50];
    
    //FIXME: This check makes [UrosWindowManager checkOthersWM]  redundant; Use checkOthersWm or this one. 
    if (![managerSelection acquireWithManagerWindow: window replace:YES])
    {
        NSLog(@"There is a window manager already running on screen #%d and it was not replaced", screen_id);
        return;
    }
    managerWindow = window;
    
    uint32_t events[2];
    //events[0] = XCB_NONE; CHECK ON THE MANUAL: it should be done in this way, but I don't get the expected beahvior
    events[0] = XCB_EVENT_MASK_FOCUS_CHANGE | XCB_EVENT_MASK_EXPOSURE |
	  XCB_EVENT_MASK_KEY_PRESS | XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY |
	  XCB_EVENT_MASK_STRUCTURE_NOTIFY |
	  XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT;
    [rootWindow changeWindowAttributes: XCB_CW_EVENT_MASK | XCB_CW_OVERRIDE_REDIRECT values: events];
    
    EWMHSetSupported([uScreen rootWindow], managerWindow, [NSArray arrayWithObjects: EWMH_WMWindowType, EWMH_WMWindowTypeDock,
                                                                                                        EWMH_WMWindowTypeDesktop,
	                                                             EWMH_WMWindowTypeMenu,
	                                                             EWMH_WMWindowTypeToolbar,
	                                                             EWMH_WMWindowTypeNormal,
                                                                                                        EWMH_WMWindowTypeUtility,
	                                                             EWMH_WMWindowTypeDialog,
	                                                             EWMH_WMWindowTypeDropdownMenu,
	                                                             EWMH_WMWindowTypePopupMenu,
	                                                             EWMH_WMWindowTypeSplash,
	                                                             EWMH_WMWindowTypeTooltip,
	                                                             EWMH_WMWindowTypeNotification,
	                                                             EWMH_WMWindowTypeCombo,
	                                                             EWMH_WMWindowTypeDnd,
	                                                             ICCCMWMTakeFocus,
	                                                             nil]);
    ICCCMSetSupportedProtocols([uScreen rootWindow], [NSArray arrayWithObjects: ICCCMWMTakeFocus, nil]);
    
    [uScreen setTrackingChildren:YES];
    NSLog(@"Uroswm UScreen: The children %@", [uScreen childWindows]);
}
@end