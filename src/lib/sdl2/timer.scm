(define sdl::delay
    (c-lambda (Uint32) void
        "SDL_Delay"))