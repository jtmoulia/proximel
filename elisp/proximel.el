;;; proximel.el --- Distel helpers for elixir.

;; Author: Thomas Moulia
;; Maintainer: Thomas Moulia
;; Version: 0.0.1

;;; Commentary:

;; This package provides expression evaluation and autocomplete
;; via distel.

;;; Code:
(require 'distel)

(defun proximel-load-modules (node)
  "Load the proximel Elixir modules' beam code on NODE."
  (interactive (list (erl-target-node)))
  (let ((distel-ebin-directory
         (file-truename
          (concat (file-name-directory
                   (or (locate-library "proximel") load-file-name))
                  "../_build/dev/lib/proximel/ebin"))))
    (erl-spawn
      (&erl-load-backend node))))

(defun proximel-eval-string (node string)
  "Use NODE to evaluate STRING using `Elixir.Code.eval_string'."
  (interactive (list (erl-target-node)
                     (read-string "To eval: ")))
  (erl-spawn
    (erl-send-rpc node 'Elixir.Code 'eval_string
                  (list (erl-binary string)))
    (erl-receive ()
        ((['rex [result bindings]]
          (message "Result: %S, Bindings: %S" result bindings))))))


(defun proximel-autocomplete-expand (node expr &optional callback)
  "Use NODE to generate a list of completions for EXPR.  Optionally
call CALLBACK with the completions.

The proximel beam code must be loaded by `proximel-load-modules'."
  (interactive (list (erl-target-node)
                     (read-string "To expand: ")))
  (erl-spawn
    (erl-send-rpc node 'Elixir.Proximel 'expand (list expr))
    (erl-receive (callback)
        ((['rex results]
          (progn (message "results: %S" results)
                 (if callback (funcall callback results))))))))

(defun proximel-company (command &optional arg &rest ignored)
  (case command
    (prefix (when (looking-back "\\<[A-Za-z0-9_\\.\\?]+\\>")
              (match-string 0)))
    (candidates (cons :async
                      (lexical-let ((arg arg))
                        (lambda (callback)
                          (proximel-autocomplete-expand (erl-target-node) arg
                                                        callback)))))))

;; (add-to-list 'company-backends 'proximel-company)
;; (setq company-backends '(proximel-company))

(provide 'proximel)
;;; proximel.el ends here
