;;;; package.lisp

(cl:in-package cl-user)


(defpackage "https://github.com/g000001/srfi-173"
  (:use)
  (:export
   make-hook
   hook?
   list->hook
   list->hook!
   hook-add!
   hook-delete!
   hook-reset!
   hook->list
   hook-run))


(defpackage "https://github.com/g000001/srfi-173#internals"
  (:use
   "https://github.com/g000001/srfi-173"
   "https://github.com/g000001/srfi-145"
   "https://github.com/g000001/srfi-9"
   rnrs
   fiveam))


;;; *EOF*
