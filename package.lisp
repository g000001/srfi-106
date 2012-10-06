;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :srfi-106
  (:use)
  (:export
   :make-client-socket :make-server-socket :socket? :socket-port
   :call-with-socket :socket-accept :socket-send :socket-recv :socket-shutdown
   :socket-close)
  (:export
   ;; constants
   :AF_UNSPEC :AF_INET :AF_INET6 :SOCK_STREAM :SOCK_DGRAM
   :AI_PASSIVE :AI_CANONNAME :AI_NUMERICHOST :AI_V4MAPPED :AI_ALL :AI_ADDRCONFIG
   :SHUT_RD :SHUT_WR :SHUT_RDWR))


(defpackage :srfi-106.internal
  (:use :srfi-106 :rnrs-user :fiveam))


#|(mapcar #'kl:ensure-keyword '(export make-client-socket make-server-socket
   socket? socket-port call-with-socket
   socket-accept socket-send socket-recv socket-shutdown socket-close
   AF_UNSPEC AF_INET AF_INET6
   SOCK_STREAM SOCK_DGRAM
   AI_PASSIVE AI_CANONNAME AI_NUMERICHOST
   AI_V4MAPPED AI_ALL AI_ADDRCONFIG
   SHUT_RD SHUT_WR SHUT_RDWR))|#


