;;;; srfi-106.asd -*- Mode: Lisp;-*- 

(cl:in-package :asdf)

(defsystem :srfi-106
  :serial t
  :depends-on (:fiveam
               :rnrs-compat
               :usocket)
  :components ((:file "package")
               (:file "srfi-106")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-106))))
  (load-system :srfi-106)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-106.internal :srfi-106))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))

