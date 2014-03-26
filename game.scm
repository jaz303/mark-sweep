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

(define fd (sdl::rwfrom-file "cone.png" "r"))	   
(define img (sdl::img-load-png-rw fd))

(define tex (sdl::create-texture-from-surface renderer img))

(sdl::render-clear renderer)
;(sdl::render-clear renderer)
(sdl::render-present renderer)

(sdl::delay 1000)