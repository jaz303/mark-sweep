(define sdl::init-timer             #x00000001)
(define sdl::init-audio             #x00000010)
(define sdl::init-video             #x00000020)
(define sdl::init-joystick          #x00000200)
(define sdl::init-haptic            #x00001000)
(define sdl::init-gamecontroller    #x00002000)
(define sdl::init-events            #x00004000)
(define sdl::init-noparachute       #x00100000)
(define sdl::init-everything        (bitwise-ior
                                        sdl::init-timer
                                        sdl::init-audio
                                        sdl::init-video
                                        sdl::init-joystick
                                        sdl::init-haptic
                                        sdl::init-gamecontroller
                                        sdl::init-events))

(define sdl::init
    (c-lambda (Uint32) int
        "SDL_Init"))

(define sdl::init-sub-system
    (c-lambda (Uint32) int
        "SDL_InitSubSystem"))

(define sdl::quit-sub-system
    (c-lambda (Uint32) void
        "SDL_QuitSubSystem"))

(define sdl::was-init
    (c-lambda (Uint32) Uint32
        "SDL_WasInit"))

(define sdl::quit
    (c-lambda () void
        "SDL_Quit"))
