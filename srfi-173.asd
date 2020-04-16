;;;; srfi-173.asd

(cl:in-package :asdf)


(defsystem :srfi-173
  :version "20200211"
  :description "SRFI 173 for CL: Hooks"
  :long-description "SRFI 173 for CL: Hooks
https://srfi.schemers.org/srfi-173"
  :author "Amirouche Boubekki"
  :maintainer "CHIBA Masaomi"
  :serial t
  :depends-on (rnrs-compat
               srfi-145
               srfi-9)
  :components ((:file "package")
               (:file "srfi-173")
               (:file "tests")))


(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-173))))
  (let ((name "https://github.com/g000001/srfi-173")
        (nickname :srfi-173))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))


(defmethod perform ((o test-op) (c (eql (find-system :srfi-173))))
  (let ((*package*
         (find-package
          "https://github.com/g000001/srfi-173#internals")))
    (eval
     (read-from-string
      "
      (or (let ((result (run 'srfi-173)))
            (explain! result)
            (results-status result))
          (error \"test-op failed\") )"))))


;;; *EOF*
