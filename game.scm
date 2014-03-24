(include "src/init.scm")

(sdl::init sdl::init-everything)

(define window (sdl::create-window "My Window"
								   100 100
								   640 480
								   sdl::window-shown))

(define renderer (sdl::create-renderer window
									   -1
									   (bitwise-ior
									     sdl::renderer-accelerated
									     sdl::renderer-presentvsync)))
									   
(print "hello world\n")
(print renderer)
(sdl::delay 1000)