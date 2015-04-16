/*
   Project: uroswm

   Copyright (C) 2015 Alex Sangiuliano

   Author: Alex Sangiuliano

   Created: 2015-04-15 9:36:47 +0200 by Alex Sangiuliano

*/

#ifndef _UROSSCREEN_H_
#define _UROSSCREEN_H_

#import <Foundation/Foundation.h>
#import <XCBKit/XCBScreen.h>
#import <XCBKit/XCBWindow.h>
#import <XCBKit/XCBSelection.h>


@interface UrosScreen : NSObject
{
    XCBScreen *uScreen;
    uint32_t screen_id;
    
    XCBWindow *managerWindow;
    XCBSelection *managerSelection;
    
}

- (id)initWithScreen: (XCBScreen*)screen id: (uint32_t)Id;
- (XCBScreen*)screen;
- (uint32_t)screenId;
- (XCBWindow*)rootWindow;
- (void) handleScreen;
@end


#endif // _UROSSCREEN_H_