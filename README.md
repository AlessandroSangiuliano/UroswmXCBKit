Uroswm is a window manager written in objective-c on GNUstep, with xcb using XCBKit.
===========

XCBKit is a framework built on top of xcb

Goals:

1) The first goal is to make Uroswm able to move a window on the screen
2) Window resizing, minimizing; (fullscreen too?)
3) Accomplish the rist two before...

===========

Build:

To build uroswm you need to install:

1) xcb
2) XCBKit

In the uroswm folder type:

$ make

Test:

I test uroswm with Xephyr, so you need to install it.

$ Xephyr -ac -screen 800x600 -reset :1 &
$ DISPLAT=:1
$ cd obj
$ ./uroswm &

You can also use -GNU-Debug, to see some nice debug output, to do this:

$ ./uroswm --GNU-Debug=XCBConnection &

Note that I put XCBConnection as an example, you can put any class that uses NSDebugLog (and variants)
=============

Contribution:

Fork, write code, test it, report problems and do Pull Request or report Issues.
Any help is welcome.

Enjoy.
