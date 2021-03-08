#lang racket

(require web-server/servlet
         web-server/servlet-env)


(define get-host
  (lambda (headers)
    (cond
      [(empty? headers) #f]
      [(equal? (caar headers) 'host) (cdar headers)]
      [else (get-host (cdr headers))])))

(define redirect
  (lambda (req)
    (redirect-to
      (string-append
        "https://"
        (get-host (request-headers req))
        (url->string (request-uri req)))
      301)))

(thread
  (lambda ()
    (serve/servlet redirect
                   #:port 80
                   #:launch-browser? #f
                   #:servlet-regexp #rx""
                   #:quit? #f)))

(define app
  (lambda (req)
    (response/xexpr "Hello World")))

(serve/servlet app
               #:port 443
               #:launch-browser? #f
               #:servlet-regexp #rx""
               #:quit? #f
               #:ssl? #t)

