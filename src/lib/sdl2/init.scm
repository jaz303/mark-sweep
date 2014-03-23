(c-declare #<<end-of-c-declare
#include <stdlib.h>
#include <stdio.h>
#include "SDL2/SDL.h"
#include "SDL2/SDL_image.h"
end-of-c-declare
)

(c-initialize #<<end-of-c-init
atexit(SDL_Quit);
end-of-c-init
)