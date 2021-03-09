#lang racket

(require web-server/servlet
         web-server/servlet-env)


(define app
  (lambda (req)
    (response/xexpr "Hello World")))

(serve/servlet app
               #:launch-browser? #f
               #:servlet-regexp #rx""
               #:quit? #f)

