(c-define-type
	Uint32
	unsigned-int32)

(c-define-type
	sdl::window-ptr
	(pointer (type "SDL_Window")))

(c-define-type
	sdl::renderer-ptr
	(pointer (type "SDL_Renderer")))