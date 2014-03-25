GSC 			= gsc
GSCFLAGS		= -ld-options "-L/usr/local/lib -lSDL2 -lSDL2_gfx -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net"

SDL_SRC 		= src/lib/sdl2/*.scm
SRC 			= src/*.scm
MAIN 			= game.scm

game: $(SDL_SRC) $(SRC) $(MAIN)
	$(GSC) $(GSCFLAGS) -o $@ -exe $(MAIN)

clean:
	rm -f game
