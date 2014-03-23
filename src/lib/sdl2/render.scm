(define sdl::renderer-software #x00000001)
(define sdl::renderer-accelerated #x00000002)
(define sdl::renderer-presentvsync #x00000004)
(define sdl::renderer-targettexture #x00000008)

(define sdl::textureaccess-static #x00000001)
(define sdl::textureaccess-streaming #x00000002)
(define sdl::textureaccess-target #x00000003)

(define sdl::texturemodulate-none #x00000000)
(define sdl::texturemodulate-color #x00000001)
(define sdl::texturemodulate-alpha #x00000002)

(define sdl::flip-none #x00000000)
(define sdl::flip-horizontal #x00000001)
(define sdl::flip-vertical #x00000002)

(define sdl::get-num-render-drivers
    (c-lambda () int
        "SDL_GetNumRenderDrivers"))