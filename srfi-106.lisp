;;;; srfi-106.lisp

(cl:in-package :srfi-106.internal)
;; (in-readtable :srfi-106)

#|||

Constants
The following variable should be defined but it highly depends on the platform.

    AF_UNSPEC
    AF_INET
    AF_INET6
    SOCK_STREAM
    SOCK_DGRAM
    AI_PASSIVE
    AI_CANONNAME
    AI_NUMERICHOST
    AI_V4MAPPED
    AI_ALL
    AI_ADDRCONFIG
    SHUT_RD
    SHUT_WR
    SHUT_RDWR
|||#

(defconstant SHUT_RD 0)
(defconstant SHUT_WR 1)
(defconstant SHUT_RDWR 2)


;;; Constructors and predicate
(defun make-client-socket (node service &optional ai-family ai-socktype ai-flags ai-protocol)
  "Returns a client socket connected to an Internet addres. 
   The Internet address is identified by node and service. node and service must be string.
   Example value of node: \"localhost\" \"127.0.0.1\"
   Example value of service: \"http\" \"80\"
   The optional parameter may specify the created socket's behaviour."
  (usocket:socket-connect node service))


;; socket? object -> boolean
(defun socket? (object)
  "Returns #t if given object is socket object. Otherwise #f."
  (typep object 'usocket:usocket))


;; make-server-socket service [ai-family [ai-socktype [ai-protocol]]] -> socket
(defun make-server-socket (port &optional ai-family ai-socktype ai-protocol)
  "Returns a server socket waiting for connection.
   The description of node argument is the same as make-client-socket.
   The optional parameter may specify the created socket's behaviour."
  (usocket:socket-listen "localhost"
                         port
                         :reuseaddress t
                         :element-type '(unsigned-byte 8)))

;;; Socket operations
(defun socket-accept (socket)
  "Wait for an incomming connection request, and returns a fresh connected 
   client socket."
  (usocket:socket-accept socket))


;;; socket-send socket bv [flags] -> size
(defun socket-send (socket bv &optional flags)
  "Sends a binary data block to a socket and returns the sent data size.
   flags may specify the procedure's behaviour."
  (declare (ignore flags))
  (usocket:socket-send socket bv (length bv)))


;;; socket-recv socket size [flags] -> bv
(defun socket-recv (socket size &optional flags)
  "Receives a binary data block from a socket.
   flags may specify the procedure's behaviour."
  (declare (ignore flags))
  (usocket:socket-receive nil socket size))


;;; socket-shutdown socket how -> (unspeficied)
;;;    Shutdows a socket.
;;;    how must be one of the following constants;

;;;        SHUT_RD
;;;        SHUT_WR
;;;        SHUT_RDWR

#+sbcl
(sb-alien:define-alien-routine shutdown sb-alien:int
  (socket sb-alien:int)
  (how sb-alien:int))


;;; socket-shutdown socket how -> (unspeficied)
(defun socket-shutdown (socket how)
  #+sbcl 
  (shutdown (sb-bsd-sockets:socket-file-descriptor (usocket:socket socket))
            how)
  ;:unspeficied
  )


;;; socket-close  -> (unspeficied)
(defun socket-close (socket)
  "Closes a socket."
  (usocket:socket-close socket)
  :unspeficied)

;;; Port conversion

;;; socket-port socket -> binary-input/output-port

(defun socket-port (socket)
  "Returns a fresh binary input/output port associated with a socket."
  (usocket:socket-stream socket))

;;; Control feature

;;; call-with-socket socket proc -> object
(defun call-with-socket (socket proc)
  "Calls a given procedure with a given socket as an argument."
  (funcall proc socket))

;;; eof
