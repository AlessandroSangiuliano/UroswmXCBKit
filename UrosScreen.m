/*
   Project: uroswm

   Copyright (C) 2015 Alex Sangiuliano

   Author: Alex Sangiuliano

   Created: 2015-04-15 9:42:47 +0200 by Alex Sangiuliano

*/

#import "UrosScreen.h"

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
    [uScreen setTrackingChildren:YES];
}
@end