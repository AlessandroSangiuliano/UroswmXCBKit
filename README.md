Uroswm is a window manager written in objective-c on GNUstep, with xcb using XCBKit.
===========

XCBKit is a framework built on top of xcb <br />

Goals: <br />

1) The first goal is to make Uroswm able to move a window on the screen <br />
2) Window resizing, minimizing; (fullscreen too?) <br />
3) Accomplish the first two before... <br />

===========

Build: <br />
======
To build uroswm you need to install: <br />

1) xcb <br />
2) XCBKit <br />

In the uroswm folder type: <br />

$ make <br />

===========

Test: <br />
=====
I test uroswm with Xephyr, so you need to install it.<br />

$ Xephyr -ac -screen 800x600 -reset :1 & <br />
$ DISPLAY=:1 <br />
$ cd obj <br />
$ ./uroswm & <br />

You can also use -GNU-Debug, to see some nice debug output, to do this: <br />

$ ./uroswm --GNU-Debug=XCBConnection & <br />

Note that I put XCBConnection as an example, you can put any class that uses NSDebugLog <br /> (and variants) <br />

===========

Contribution: <br />
=============
Fork, write code, test it, report problems and do Pull Request or report Issues. <br />
Any help is welcome. <br />

Enjoy. <br />
