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

(for-each
	(lambda (pair)
		(define (car pair)
			(c-lambda (int) int
				"IMG_Init"))
		(print pair))
	'( 	(sdl::img-is-ico  . "IMG_isICO")
		(sdl::img-is-cur  . "IMG_isCUR")
		(sdl::img-is-bmp  . "IMG_isBMP")
		(sdl::img-is-gif  . "IMG_isGIF")
		(sdl::img-is-jpg  . "IMG_isJPG")
		(sdl::img-is-lbm  . "IMG_isLBM")
		(sdl::img-is-pcx  . "IMG_isPCX")
		(sdl::img-is-png  . "IMG_isPNG")
		(sdl::img-is-pnm  . "IMG_isPNM")
		(sdl::img-is-tif  . "IMG_isTIF")
		(sdl::img-is-xcf  . "IMG_isXCF")
		(sdl::img-is-xpm  . "IMG_isXPM")
		(sdl::img-is-xv   . "IMG_isXV")
		(sdl::img-is-webp . "IMG_isWEBP")))

(for-each
	(lambda (pair)
		(print pair))
	'( 	(sdl::img-load-ico-rw  . "IMG_LoadICO_RW")
		(sdl::img-load-cur-rw  . "IMG_LoadCUR_RW")
		(sdl::img-load-bmp-rw  . "IMG_LoadBMP_RW")
		(sdl::img-load-gif-rw  . "IMG_LoadGIF_RW")
		(sdl::img-load-jpg-rw  . "IMG_LoadJPG_RW")
		(sdl::img-load-lbm-rw  . "IMG_LoadLBM_RW")
		(sdl::img-load-pcx-rw  . "IMG_LoadPCX_RW")
		(sdl::img-load-png-rw  . "IMG_LoadPNG_RW")
		(sdl::img-load-pnm-rw  . "IMG_LoadPNM_RW")
		(sdl::img-load-tga-rw  . "IMG_LoadTGA_RW")
		(sdl::img-load-tif-rw  . "IMG_LoadTIF_RW")
		(sdl::img-load-xcf-rw  . "IMG_LoadXCF_RW")
		(sdl::img-load-xpm-rw  . "IMG_LoadXPM_RW")
		(sdl::img-load-xv-rw   . "IMG_LoadXV_RW")
		(sdl::img-load-webp-rw . "IMG_LoadWEBP_RW")))


