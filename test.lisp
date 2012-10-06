(cl:in-package :srfi-106.internal)

(def-suite srfi-106)

(in-suite srfi-106)


(defparameter echo-server-socket (make-server-socket 5000))

;(describe  echo-server-socket)


(define-function (get-line-from-binary-port bin)
  (let ((octets (make-array 0
                            :fill-pointer 0
                            :adjustable T
                            :element-type '(unsigned-byte 8))))
    (let loop ((b (read-byte bin)))
         (case b
           ((#xA) T) ;; newline
           ((#xD) (loop (read-byte bin))) ;; carriage return
           (otherwise 
            (vector-push-extend b octets)
            (loop (read-byte bin)))))
    (babel:octets-to-string octets :encoding :utf-8)))


(define-function (server-run)
  (let ((addr (socket-accept echo-server-socket)))
    ;; (describe addr)
    (call-with-socket 
     addr
     (lambda (sock)
       (let ((p (socket-port sock)))
         (let lp2 ((r (get-line-from-binary-port p)))
              (write-sequence (babel:string-to-octets 
                               (concatenate 'cl:string
                                            r
                                            (string #\Return)
                                            (string #\Linefeed)))
                              p)
              (force-output p)
              (lp2 (get-line-from-binary-port p))))))))

;(server-run)

;; (socket-shutdown echo-server-socket 0)

;; (socket-close echo-server-socket)


