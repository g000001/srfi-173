(cl:in-package "https://github.com/g000001/srfi-173#internals")


(def-suite* srfi-173)


;; test hook->list and make-hook
(test |test hook->list and make-hook|
  (is (eqv? 0 (length (hook->list (make-hook 0))))))


;; test hook-add!
(test |test hook-add!|
  (is (eqv? 1 (let ((hook (make-hook 0))
                    (counter 0))
                (hook-add! hook (lambda () (set! counter (+ counter 1))))
                (length (hook->list hook))))))


;; test hook-delete!
(test |test hook-delete!|
  (is (eqv? 0 (let ((hook (make-hook 0))
                    (counter 0))
                (let ((increment (lambda () (set! counter (+ counter 1)))))
                  (hook-add! hook increment)
                  (hook-delete! hook increment)
                  (length (hook->list hook)))))))


;; test hook-reset!
(test |test hook-reset!|
  (is (eqv? 0 (let ((hook (make-hook 0))
                    (counter 0))
                (let ((increment (lambda () (set! counter (+ counter 1))))
                      (decrement (lambda () (set! counter (- counter 1)))))
                  (hook-add! hook increment)
                  (hook-reset! hook)
                  (length (hook->list hook)))))))


;; test hook-run
(test |test hook-run|
  (is (eqv? 0 (let ((hook (make-hook 0))
                    (counter 0))
                (let ((increment (lambda () (set! counter (+ counter 1))))
                      (decrement (lambda () (set! counter (- counter 1)))))
                  (hook-add! hook increment)
                  (hook-add! hook decrement)
                  (hook-run hook)
                  counter)))))


;; test list->hook
(test |test list->hook|
  (is (eqv? 0 (let* ((counter 0)
                     (increment (lambda () (set! counter (+ counter 1))))
                     (decrement (lambda () (set! counter (- counter 1)))))
                (let ((hook (list->hook 0 (list increment decrement))))
                  (hook-add! hook increment)
                  (hook-add! hook decrement)
                  (hook-run hook)
                  counter)))))


;; test list->hook!
(test |test list->hook!|
  (is (eqv? 0 (let* ((counter 0)
                     (increment (lambda () (set! counter (+ counter 1))))
                     (decrement (lambda () (set! counter (- counter 1))))
                     (hook (make-hook 0)))
                (list->hook! hook (list increment decrement))
                (hook-add! hook increment)
                (hook-add! hook decrement)
                (hook-run hook)
                counter))))


;;; *EOF*
