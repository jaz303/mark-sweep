(c-declare #<<end-of-c-declare
#include <stdlib.h>
#include <stdio.h>
#include "SDL2/SDL.h"
#include "SDL2/SDL_image.h"
#include "SDL2/SDL_timer.h"
#include "SDL2/SDL_mixer.h"
#include "SDL2/SDL_surface.h"
#include "SDL2/SDL_ttf.h"
#include "SDL2/SDL_net.h"
#include "SDL2/SDL_shape.h"
end-of-c-declare
)

(c-initialize #<<end-of-c-init
atexit(SDL_Quit);
end-of-c-init
)