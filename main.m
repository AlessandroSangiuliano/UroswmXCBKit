/*
   Project: uroswm

   Author: alex,,,

   Created: 2015-04-11 10:57:04 +0200 by alex
*/

#import <Foundation/Foundation.h>
#import "UrosWindowManager.h"

int main(int argc, const char *argv[])
{
  UrosWindowManager *controller = [[UrosWindowManager alloc] init];
  [controller RunLoop];
  return 0;
}

