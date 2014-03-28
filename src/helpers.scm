;; https://mercure.iro.umontreal.ca/pipermail/gambit-list/2009-May/003472.html
;; Defines the c-define-struct macro, which extends the Gambit FFI to
;; interface to C structures.

(define-macro (c-define-struct type . fields)
   (let* ((type-str
           (symbol->string type))
          (sym
           (lambda strs (string->symbol (apply string-append strs))))
          (struct-type-str
           (string-append "struct " type-str))
          (struct-type*-str
           (string-append struct-type-str "*"))
          (release-type-str
           (string-append "release_" type-str))
          (type*
           (sym type-str "*"))
          (type*/nonnull
           (sym type-str "*/nonnull"))
          (type*/release-rc
           (sym type-str "*/release-rc"))
          (expansion
           `(begin

              ;; Define the release function which is called when the
              ;; object is no longer accessible from the Scheme world.

              (c-declare
               ,(string-append
                 "static ___SCMOBJ " release-type-str "( void* ptr )\n"
                 "{\n"
                 "  ___EXT(___release_rc)( ptr );\n"
                 "  return ___FIX(___NO_ERR);\n"
                 "}\n"))

              ;; Define the C types.

              (c-define-type ,type (struct ,type-str))
              (c-define-type ,type* (pointer ,type (,type*)))
              (c-define-type ,type*/nonnull (nonnull-pointer ,type  
(,type*)))
              (c-define-type ,type*/release-rc (nonnull-pointer ,type  
(,type*) ,release-type-str))

              ;; Define type allocator procedure.

              (define ,(sym "alloc-" type-str)
                (c-lambda ()
                          ,type*/release-rc
                          ,(string-append "___result_voidstar =  
___EXT(___alloc_rc)( sizeof( " struct-type-str " ) );")))

              ;; Define field getters.

              ,@(map (lambda (field-spec)
                       (let* ((field (car field-spec))
                              (field-str (symbol->string field))
                              (field-type (cadr field-spec)))
                         `(define ,(sym type-str "-" field-str)
                            (c-lambda (,type*/nonnull)
                                      ,field-type
                                      ,(string-append "___result =  
___arg1->" field-str ";")))))
                     fields)

              ;; Define field setters.

              ,@(map (lambda (field-spec)
                       (let* ((field (car field-spec))
                              (field-str (symbol->string field))
                              (field-type (cadr field-spec)))
                         `(define ,(sym type-str "-" field-str "-set!")
                            (c-lambda (,type*/nonnull ,field-type)
                                      void
                                      ,(string-append "___arg1->"  
field-str " = ___arg2;")))))
                     fields))))

     (if #f ;; change to #f if not debugging
         (pp `(definition:
               (c-define-struct ,type , at fields)
               expansion:
               ,expansion)))

     expansion))