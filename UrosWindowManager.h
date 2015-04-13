/*
   Project: uroswm

   Copyright (C) 2015 Alex Sangiuliano

   Author: Alex Sangiuliano

   Created: 2015-04-12 10:21:47 +0200 by alex

*/

#ifndef _UROSWINDOWMANAGER_H_
#define _UROSWINDOWMANAGER_H_

#import <Foundation/Foundation.h>
#import <XCBKit/XCBConnection.h>

@interface UrosWindowManager : NSObject
{
    XCBConnection *theConnection;
    /*useless for now. I can use it if I want to replace the running one
    *so I can continue the ececution of uroswm using NSException to replace the
    *running one
    */
    //BOOL anotherWmIsRunning; 
   
}

- (void) RunLoop;
/**
 * This method checks if another window manager is running
 */
- (void) checkOthersWM;
@end

#endif // _UROSWINDOWMANAGER_H_

