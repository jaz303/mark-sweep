(define sdl::img-init-jpg   #x00000001)
(define sdl::img-init-png   #x00000002)
(define sdl::img-init-tif   #x00000004)
(define sdl::img-init-webp  #x00000008)

(define sdl::img-init
    (c-lambda (int) int
        "IMG_Init"))

(define sdl::img-quit
    (c-lambda () void
        "IMG_Quit"))
