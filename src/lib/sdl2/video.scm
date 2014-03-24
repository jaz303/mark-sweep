(define sdl::window-fullscreen #x00000001)
(define sdl::window-opengl #x00000002)
(define sdl::window-shown #x00000004)
(define sdl::window-hidden #x00000008)
(define sdl::window-borderless #x00000010)
(define sdl::window-resizable #x00000020)
(define sdl::window-minimized #x00000040)
(define sdl::window-maximized #x00000080)
(define sdl::window-input-grabbed #x00000100)
(define sdl::window-input-focus #x00000200)
(define sdl::window-mouse-focus #x00000400)
(define sdl::window-fullscreen-desktop)
(define sdl::window-foreign #x00000800)
(define sdl::window-allow-highdpi #x00002000)

; TODO: SDL_WindowEventID
; TODO: SDL_GLattr
; TODO: SDL_GLprofile
; TODO: SDL_GLcontextFlag

(define sdl::get-num-video-drivers
    (c-lambda () int
        "SDL_GetNumVideoDrivers"))

(define sdl::get-video-driver
    (c-lambda (int) char-string
        "SDL_GetVideoDriver"))

(define sdl::video-init
    (c-lambda (char-string) int
        "SDL_VideoInit"))

(define sdl::video-quit
    (c-lambda () void
        "SDL_VideoQuit"))

(define sdl::get-current-video-driver
    (c-lambda () char-string
        "SDL_GetCurrentVideoDriver"))

(define sdl::get-num-video-displays
    (c-lambda () int
        "SDL_GetNumVideoDisplays"))

(define sdl::get-display-name
    (c-lambda (int) char-string
        "SDL_GetDisplayName"))

; SDL_GetDisplayBounds
; SDL_GetNumDisplayModes
; SDL_GetDisplayMode
; SDL_GetDesktopDisplayMode
; SDL_GetCurrentDisplayMode
; SDL_GetClosestDisplayMode

(define sdl::create-window
	(c-lambda (char-string int int int int Uint32) sdl::window-ptr
		"SDL_CreateWindow"))