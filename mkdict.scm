(use srfi-13)
(use gauche.generator)
(use gauche.parseopt)

(define (make-entry key line)
  (let ((v (regexp-replace-all #/[\[\;\/]/
                               line
                               (lambda (m)
                                 (format "[~2,'0x]"
                                  (char->integer (string-ref (m 0) 0)))))))
    (format "~A /~A/" key v)))

(define (main args)
  (let-args (cdr args)
      ((key "k=s" "ーわ"))
    (do-generator (line read-line)
      (print
       (cond ((#/^\\/ line)
              (make-entry key (string-drop line 1)))
             ((#/^\;/ line)
              line)
             (else
              (make-entry key line)))))
    0))
