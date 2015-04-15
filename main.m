/*
   Project: uroswm
   
   Copyright (C) 2015 Alex Sangiuliano

   Author: Alex Sangiuliano

   Created: 2015-04-11 10:57:04 +0200 by Alex Sangiuliano
*/

#import <Foundation/Foundation.h>
#import "UrosWindowManager.h"

int main(int argc, const char *argv[])
{
  UrosWindowManager *controller = [[UrosWindowManager alloc] init];
  [controller RunLoop];
  return 0;
}

