(c-define-type
    SDL_bool
    int)

(c-define-type
    Uint64
    unsigned-int64)

(c-define-type
    Uint32
    unsigned-int32)

(c-define-type
    Uint16
    unsigned-int16)

(c-define-type
    Uint8
    unsigned-int8)

(c-define-type
    sdl::renderer-info-ptr
    (pointer "SDL_RendererInfo"))

(c-define-type
    sdl::window-ptr
    (pointer "SDL_Window"))

(c-define-type
    sdl::renderer-ptr
    (pointer "SDL_Renderer"))

(c-define-type
    sdl::surface-ptr
    (pointer "SDL_Surface"))

(c-define-type
    sdl::texture-ptr
    (pointer "SDL_Texture"))

(c-define-type
    sdl::cursor-ptr
    (pointer "SDL_Cursor"))

(c-define-type
    sdl::ttf-font-ptr
    (pointer "TTF_Font"))

(c-define-type
    sdl::thread-ptr
    (pointer "SDL_Thread"))

(c-define-type
    sdl::rw-ops-ptr
    (pointer "SDL_RWops"))

